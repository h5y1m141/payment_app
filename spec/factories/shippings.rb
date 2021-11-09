FactoryBot.define do
  factory :shipping do
    order { nil }
    status { 1 }

    trait :shipping_request do
      status { 1 }
    end

    trait :shipping_in_ready do
      status { 2 }
    end

    trait :shipping_complete do
      status { 3 }
    end
  end
end
