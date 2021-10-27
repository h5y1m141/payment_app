module Entities
  module V2
    class ProductEntity < Grape::Entity
      expose :id
      expose :name
      expose :price
    end
  end
end
