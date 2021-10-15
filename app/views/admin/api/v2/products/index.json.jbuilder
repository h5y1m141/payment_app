json.products do
  json.array! @products do |product|
    json.id product[:id]
    json.name product[:name]
    json.price product.price
    json.currnt_stock product.currnt_stock
  end
end
