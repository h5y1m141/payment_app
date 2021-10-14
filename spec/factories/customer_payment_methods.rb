FactoryBot.define do
  factory :customer_payment_method do
    customer
    payment_method_id { 'pm_12345678' }
    exp_month { 1 }
    exp_year { 2029 }
    brand { 'visa' }
  end
end
