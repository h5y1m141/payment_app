FactoryBot.define do
  factory :customer do
    uid { '0123456789ZA4GCK0qZyaokt4KW2' }
    stripe_customer_id { 'cus_12345678' }
  end
end
