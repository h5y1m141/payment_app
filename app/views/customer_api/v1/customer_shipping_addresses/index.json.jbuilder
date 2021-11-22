json.cache! ['customer_api', 'v1', @customer_shipping_addresses], expires_in: 10.minutes do
  json.customer_shipping_addresses do
    json.array! @customer_shipping_addresses do |customer_shipping_address|
      json.id customer_shipping_address[:id]
      json.zipcode customer_shipping_address[:zipcode]
      json.prefecture_name customer_shipping_address[:prefecture_name]
      json.address customer_shipping_address[:address]
    end
  end
end
