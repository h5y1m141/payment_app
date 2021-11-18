module CustomerApi
  module V1
    class CancellationOrdersController < ApplicationController
      before_action :verify_token, only: %i[create]

      def create
        shipping = RequestCancellationShipping.execute(params[:order_id])

        if shipping
          render json: { shipping: { id: 'test' } }, status: :created
        else
          render status: :internal_server_error
        end
      end
    end
  end
end
