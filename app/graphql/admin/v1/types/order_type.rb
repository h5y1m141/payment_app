module Admin
  module V1
    module Types
      class OrderType < Types::BaseObject
        field :id, ID, null: false
        field :quantity, Int, null: false
        field :product, ProductType, null: false

        field :created_at, GraphQL::Types::ISO8601DateTime, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

        def product
          # rubocop:disable Layout/LineLength
          # 普通に書いてしまうと以下のロジック相当の処理になってN+1が発生してしまう
          # Product Load (1.3ms)  SELECT "products".* FROM "products" WHERE "products"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
          # Product Load (1.2ms)  SELECT "products".* FROM "products" WHERE "products"."id" = $1 LIMIT $2  [["id", 6], ["LIMIT", 1]]
          # ただし、GraphQLの場合クエリにどんなフィールドが含まれるかを事前に予測しきれないため
          # 以下のようなことは不可
          # Order.all.includes(:product).xxxx
          # 回避方法としてGraphQL::Batchの仕組みを利用する
          Admin::V1::RecordLoader.for(Product).load(object.product_id)
          # rubocop:enable Layout/LineLength
        end
      end
    end
  end
end
