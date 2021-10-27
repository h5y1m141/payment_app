module Admin
  module Api
    module V2
      class CustomersController < ApplicationController
        def show
          @customer = Customer(params[:id])
        end

        def create
          result = AuthToken.verify(customer_params[:id_token])

          if result['uid'].blank?
            render status: :unauthorized, json: { status: 401, message: 'Unauthorized' }
          else
            @customer = Customer.find_or_create_stripe_customer(customer_params[:uid])

            render :show
          end
        end

        private

        def customer_params
          params.permit(:uid, :id_token)
        end
      end
    end
  end
end
