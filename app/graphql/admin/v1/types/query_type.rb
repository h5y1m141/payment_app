module Admin
  module V1
    module Types
      class QueryType < Types::BaseObject
        # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
        include GraphQL::Types::Relay::HasNodeField
        include GraphQL::Types::Relay::HasNodesField

        # null:true/falseの挙動の違いは以下の通り
        # null: true は該当のあ互い万一存在しない場合は nilを返す
        # null: falseが反対に確実に該当のデーター型の値を返す
        # 詳しくは公式を参照
        # https://graphql-ruby.org/fields/introduction.html
        field :products, [ProductType], null: true
        field :product, ProductType, null: false do
          argument :id, ID, required: true
        end

        field :user_orders, UserOrderType, null: true do
          argument :id, ID, required: true
        end

        field :orders, [OrderType], null: false

        def products
          Product.all.order(:id)
        end

        def product(id:)
          Product.find(id)
        end

        def user_orders(id:)
          User.find(id)
        end

        def orders
          Order.all
        end
      end
    end
  end
end
