class FixCancellationShipping
  class << self
    def execute(order_id)
      order = Order.find(order_id)

      if order.present?
        ActiveRecord::Base.transaction do
          shipping = Shipping.create!(
            order: order,
            status: Shipping.statuses[:cancellation_complete]
          )
          order.order_items do |order_item|
            product = Product.find_by!(name: order_item[:product_name])
            product.with_lock do
              # キャンセル処理のため注文時の在庫数を増やす
              ProductStock.create!(
                product: product,
                stock: order_item[:quantity]
              )
            end
          end

          shipping
        end
      end
    end
  end
end
