module Admin
  module V1
    module Types
      module NodeType
        include Types::BaseInterface
        # Add the `id` field
        include GraphQL::Types::Relay::NodeBehaviors
      end
    end
  end
end
