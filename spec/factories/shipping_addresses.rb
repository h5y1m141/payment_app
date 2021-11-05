FactoryBot.define do
  factory :shipping_address do
    customer { nil }
    zipcode { "MyString" }
    prefecture { nil }
    address { "MyString" }
  end
end
