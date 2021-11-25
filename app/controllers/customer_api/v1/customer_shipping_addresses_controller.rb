module CustomerApi
  module V1
    class CustomerShippingAddressesController < ApplicationController
      before_action :verify_token, only: %i[index]

      def index
        @customer_shipping_addresses = @current_customer.shipping_addresses
      end
    end
  end
end
