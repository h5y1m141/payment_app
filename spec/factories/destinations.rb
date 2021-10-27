FactoryBot.define do
  factory :destination do
    zipcode { 'MyString' }
    address { 'MyString' }
    order { nil }
  end
end
