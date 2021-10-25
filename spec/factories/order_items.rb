FactoryBot.define do
  factory :order_item do
    order { nil }
    product_name { 'MyString' }
    product_unit_price { 1 }
    quantity { 1 }
    sub_total { 1 }
  end
end
