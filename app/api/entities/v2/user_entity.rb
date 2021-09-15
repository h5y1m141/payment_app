module Entities
  module V2
    class UserEntity < Grape::Entity
      expose :id
      expose :uid
    end
  end
end