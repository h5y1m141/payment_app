json.cache! ['admin', 'api', 'v2', @products], expires_in: 10.minutes do
  json.products do
    json.array! @products do |product|
      json.id product[:id]
      json.name product[:name]
      json.price product.price
    end
  end
end
