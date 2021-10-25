module Admin
  module V1
    module Mutations
      class CreateOrder < Mutations::BaseMutation
        argument :user_id, ID, required: true
        argument :product_id, ID, required: true
        argument :quantity, Int, required: true
        argument :amount, Int, required: true

        field :order, Types::OrderType, null: false

        def resolve(**args)
          order = Operations::CreateOrder.execute(args)
          raise GraphQL::ExecutionError, '注文を受け付けることが出来ません' unless order

          { order: order }
        end
      end
    end
  end
end
