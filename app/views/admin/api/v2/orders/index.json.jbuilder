json.orders do
  json.array! @orders do |order|
    json.id order[:id]
    json.paymentIntentId order[:payment_intent_id]
    json.status order.shipping_state.aasm.current_state.to_s.camelize
    json.totalPrice order[:total_price]
    json.customer do
      json.id order.customer.id
      json.uid order.customer.uid
    end
    json.orderItems do
      json.array! order.order_items do |order_item|
        json.productName order_item.product_name
        json.productUnitPrice order_item.product_unit_price
        json.quantity order_item.quantity
      end
    end
  end
end
