module CustomerApi
  module V1
    class CustomerPaymentMethodsController < ApplicationController
      before_action :verify_token, only: %i[index]

      def index
        @customer_payment_methods = @current_customer.customer_payment_methods
      end
    end
  end
end
