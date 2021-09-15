json.cache! ['admin', 'api', 'v2', @orders], expires_in: 1.minutes do
  json.orders do
    json.array! @orders do |order|
      json.id order[:id]
      json.quantity order[:quantity]
      json.amount order[:amount]
      json.product do
        json.id order[:product_id]
        json.name order.product.name
      end
    end
  end
end
