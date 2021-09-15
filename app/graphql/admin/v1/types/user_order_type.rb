module Admin
  module V1
    module Types
      class UserOrderType < Types::BaseObject
        field :id, ID, null: false
        field :uid, String, null: false
        field :orders, [OrderType], null: true

        def orders
          Admin::V1::CollectionLoader.for(User, :orders).load(object)
        end
      end
    end
  end
end
