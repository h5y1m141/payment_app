module Admin
  module V1
    module Types
      class MutationType < Types::BaseObject
        field :create_product, mutation: Mutations::CreateProduct
        field :create_order, mutation: Mutations::CreateOrder
      end
    end
  end
end
