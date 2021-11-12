FactoryBot.define do
  factory :shipping do
    order
    status { 1 }

    trait :shipping_request do
      status { 1 }
    end

    trait :shipping_in_ready do
      status { 2 }
    end

    trait :cancellation_request do
      status { 3 }
    end

    trait :cancellation_complete do
      status { 4 }
    end

    trait :shipping_complete do
      status { 5 }
    end
  end
end
