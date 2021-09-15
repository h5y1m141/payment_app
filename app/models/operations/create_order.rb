module Operations
  class CreateOrder
    class << self
      def execute(params)
        product = Product.find(params[:product_id])
        quantity = params[:quantity].to_i
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
          Order.create!(params)
        end
      end
    end
  end
end