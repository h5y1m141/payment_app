module Admin
  module V1
    module Inputs
      class CartItemInputType < Types::BaseInputObject
        argument :subTotal, Int, required: true
        argument :quantity, Int, required: true
        argument :product, Inputs::ProductInputType, required: true
      end
    end
  end
end
