FactoryBot.define do
  factory :shipping_address do
    customer
    zipcode { 'MyString' }
    prefecture
    address { 'MyString' }
  end
end
