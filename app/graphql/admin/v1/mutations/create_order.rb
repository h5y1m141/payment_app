module Admin
  module V1
    module Mutations
      class CreateOrder < Mutations::BaseMutation
        argument :id_token, String, required: true
        argument :uid, String, required: true
        argument :total_price, Int, required: true
        argument :cart_items, [Inputs::CartItemInputType], required: true
        argument :payment_method, Inputs::PaymentMethodInputType, required: true

        field :order, Types::OrderType, null: false

        def resolve(**args)
          order = CreateOrderAndAdjustProductStock.execute(args)
          raise GraphQL::ExecutionError, '注文を受け付けることが出来ません' unless order

          { order: order }
        end
      end
    end
  end
end
