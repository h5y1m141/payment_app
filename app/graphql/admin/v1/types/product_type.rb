module Admin
  module V1
    module Types
      class ProductType < Types::BaseObject
        field :id, ID, null: false
        field :name, String, null: false
        field :price, Int, null: false

        field :created_at, GraphQL::Types::ISO8601DateTime, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      end
    end
  end
end
