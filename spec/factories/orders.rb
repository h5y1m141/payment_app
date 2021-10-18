FactoryBot.define do
  factory :order do
    customer
    payment_intent_id { 'pi_123456' }
    total_price { 1 }
  end
end
