FactoryBot.define do
  factory :order do
    product { nil }
    quantity { 1 }
    amount { 1 }
  end
end
