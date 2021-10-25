module Entities
  module V2
    class CustomerEntity < Grape::Entity
      expose :id
      expose :uid
    end
  end
end