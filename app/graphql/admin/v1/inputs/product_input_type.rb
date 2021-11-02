module Admin
  module V1
    module Inputs
      class ProductInputType < Types::BaseInputObject
        argument :id, ID, required: true
        argument :name, String, required: true
        argument :price, Int, required: true
      end
    end
  end
end
