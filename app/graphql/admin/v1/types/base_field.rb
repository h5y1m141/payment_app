module Admin
  module V1
    module Types
      class BaseField < GraphQL::Schema::Field
        argument_class Types::BaseArgument
      end
    end
  end
end
