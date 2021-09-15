FactoryBot.define do
  factory :payment do
    order { nil }
    payment_method { nil }
    payment_type { 1 }
    code { "MyString" }
  end
end
