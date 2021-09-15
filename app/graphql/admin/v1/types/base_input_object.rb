module Admin
  module V1
    module Types
      class BaseInputObject < GraphQL::Schema::InputObject
        argument_class Types::BaseArgument
      end
    end
  end
end
