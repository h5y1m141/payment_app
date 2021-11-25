json.cache! ['customer_api', 'v1', @customer_shipping_addresses], expires_in: 10.minutes do
  json.customer_shipping_addresses do
    json.array! @customer_shipping_addresses do |customer_shipping_address|
      json.id customer_shipping_address[:id].to_s
      json.zipcode customer_shipping_address[:zipcode]
      json.full_address customer_shipping_address.full_address
    end
  end
end
