json.cache! ['admin', 'api', 'v2', @orders], expires_in: 1.minute do
  json.orders do
    json.array! @orders do |order|
      json.id order[:id]
      json.payment_intent_id order[:payment_intent_id]
      json.total_price order[:total_price]
      json.customer do
        json.id order.customer.id
        json.uid order.customer.uid
      end
    end
  end
end
