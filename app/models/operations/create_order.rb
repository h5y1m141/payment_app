module Operations
  class CreateOrder
    class << self
      def execute(params)
        payment_method_id = params[:payment_method][:id]
        cart_items = params[:cart_items]
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
            order = Order.create!({
              product_id: product.id,
              user_id: User.first.id,
              quantity: quantity,
              amount: cart_item[:subTotal].to_i
            })
          end
        end
        order = Stripe::PaymentIntent.create({
          amount: params[:total_price],
          currency: 'jpy',
          payment_method: payment_method_id
        })
        order
      end
    end
  end
end