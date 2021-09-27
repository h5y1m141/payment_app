# json.cache! ['admin', 'api', 'v2', @order], expires_in: 1.minutes do
#   json.order do
#     json.id @order[:id]
#     json.quantity @order[:quantity]
#     json.amount @order.amount
#     json.product do
#       json.id @order.product_id
#       json.name @order.product.name
#     end
#   end
# end

json.order do
  json.id 'paymentid'
end