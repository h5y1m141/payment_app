module Entities
  module V2
    class OrderEntity < Grape::Entity
      expose :id
      expose :total_price
      expose :customer, using: Entities::V2::CustomerEntity
      expose :payment_intent_id
    end
  end
end