module Entities
  module V2
    class OrderEntity < Grape::Entity
      expose :id
      expose :product, using: Entities::V2::ProductEntity
      expose :user, using: Entities::V2::UserEntity
      expose :quantity
      expose :amount
    end
  end
end