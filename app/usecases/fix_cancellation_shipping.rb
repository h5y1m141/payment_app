class FixCancellationShipping
  class << self
    def execute(order_id) # rubocop:disable Metrics/MethodLength
      order = Order.find(order_id)
      return if order.blank?

      ActiveRecord::Base.transaction do
        Stripe::Refund.create(
          {
            payment_intent: order.payment_intent_id
          }
        )
        shipping_state = ShippingState.find_by(
          order_id: order_id
        )
        shipping_state.cancel_complete!
        order.order_items.each do |order_item|
          product = Product.find_by!(name: order_item[:product_name])

          product.with_lock do
            # キャンセル処理のため注文時の在庫数を増やす
            ProductStock.create!(
              product: product,
              stock: order_item[:quantity]
            )
          end
        end

        shipping_state
      end
    end
  end
end
