module Operations
  class CreateOrder
    class << self
      # NOTE：サンプルのアプリのため在庫の調整処理と決済プロバイダーの処理を同一のトランザクションで処理
      # ただ実際の案件の場合には想定要件を踏まえてトランザクションの単位をしっかり検討する必要ある
      # 以下の記事が参考になる
      # https://logmi.jp/tech/articles/324990
      def execute(params)
        payment_intent = Stripe::PaymentIntent.create({
          amount: params[:total_price],
          currency: 'jpy',
          payment_method: params[:payment_method][:id],
          confirm: true
        })
        customer = find_or_create_customer(params[:uid])
        order = Order.create!({
          customer_id: customer.id,
          payment_intent_id: payment_intent.id,
          total_price: params[:total_price]
        })
        adjust_product_stock_and_create_order_item(
          cart_items: params[:cart_items], 
          order: order
        )
        order
      end

      private

      def find_or_create_customer(uid)
        customer = Customer.find_by(uid: uid)
        return customer if customer.present?

        stripe_customer = Stripe::Customer.create({
          metadata: {
            payment_app_customer_uid: uid
          }
        })
        Customer.create(
          uid: uid,
          stripe_customer_id: stripe_customer.id
        )
      end

      def adjust_product_stock_and_create_order_item(cart_items:, order:)
        cart_items.each do |cart_item|
          product = Product.find(cart_item[:product][:id])
          quantity = cart_item[:quantity].to_i
          return false if quantity > product.currnt_stock

          # ProductStockへのINSERTが重複して行われるとファントムリードが発生
          # それぞれで参照しないID同士を参照しあう可能性あり、結果デッドロックになる可能性ある
          # デッドロックを回避するために親テーブルの対象のidに対して排他ロックを行って処理を行う
          product.with_lock do
            # 注文された件数分在庫数を減らす必要あるので以下実施
            ProductStock.create!(
              product: product,
              stock: quantity * -1
            )
            OrderItem.create!({
              order: order,
              product_name: product.name,
              product_unit_price: product.price,
              quantity: quantity,
              sub_total: cart_item[:subTotal].to_i
            })
          end
        end
      end
    end
  end
end