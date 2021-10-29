module Admin
  module V1
    module Inputs
      class CardInputType < Types::BaseInputObject
        argument :brand, String, required: true
        argument :last4, String, required: true
        argument :exp_month, Int, required: true
        argument :exp_year, Int, required: true
      end
    end
  end
end
