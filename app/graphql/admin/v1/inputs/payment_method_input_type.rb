module Admin
  module V1
    module Inputs
      class PaymentMethodInputType < Types::BaseInputObject
        argument :id, ID, required: true
        argument :card, Inputs::CardInputType, required: true
      end
    end
  end
end
