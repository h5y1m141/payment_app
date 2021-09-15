FactoryBot.define do
  factory :user_credit_card do
    user { nil }
    card_id { "MyString" }
    exp_month { 1 }
    exp_year { 1 }
    brand { "MyString" }
  end
end
