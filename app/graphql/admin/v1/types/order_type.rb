module Admin
  module V1
    module Types
      class OrderType < Types::BaseObject
        field :id, ID, null: false
        field :total_price, Int, null: false

        field :created_at, GraphQL::Types::ISO8601DateTime, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      end
    end
  end
end
