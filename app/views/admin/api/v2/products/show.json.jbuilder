json.cache! ['admin', 'api', 'v2', @product], expires_in: 10.minutes do
  json.id @product[:id]
  json.name @product[:name]
  json.price @product.price
end
