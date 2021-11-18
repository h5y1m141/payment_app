json.products do
  json.array! @products do |product|
    json.id product[:id]
    json.name product[:name]
    json.price product.price
    json.current_stock product.current_stock
  end
end
