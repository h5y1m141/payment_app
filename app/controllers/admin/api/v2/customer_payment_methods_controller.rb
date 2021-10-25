module Admin
  module Api
    module V2
      class CustomerPaymentMethodsController < ApplicationController
        def index
          return [] if params[:uid].blank?
          
          customer = Customer.find_by(uid: params[:uid])
          return [] if customer.blank?

          @customer_payment_methods = customer.customer_payment_methods
        end
      end
    end
  end
end
