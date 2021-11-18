json.cache! ['admin', 'api', 'v2', @customer_payment_methods], expires_in: 10.minutes do
  json.customer_payment_methods do
    json.array! @customer_payment_methods do |customer_payment_method|
      json.id customer_payment_method[:id]
      json.payment_method_id customer_payment_method[:payment_method_id]
      json.exp_month customer_payment_method[:exp_month]
      json.exp_year customer_payment_method[:exp_year]
      json.brand customer_payment_method[:brand]
    end
  end
end
