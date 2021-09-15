module Admin
  module V1
    module Mutations
      class CreateProduct < Mutations::BaseMutation
        argument :name, String, required: true
        argument :price, Int, required: true

        field :product, Types::ProductType, null: false

        def resolve(**args)
          product = Product.create(args)
          { product: product }
        rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
          rental.destroy
          raise GraphQL::ExecutionError, e.message
        end
      end
    end
  end
end
