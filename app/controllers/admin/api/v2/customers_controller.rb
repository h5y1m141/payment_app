module Admin
  module Api
    module V2
      class CustomersController < ApplicationController
        def show
          @customer = Customer(params[:id])
        end

        def create
          @customer = Customer.create(customer_params)

          render :show
        end

        private

        def customer_params
          params.permit(:uid)
        end
      end
    end
  end
end
