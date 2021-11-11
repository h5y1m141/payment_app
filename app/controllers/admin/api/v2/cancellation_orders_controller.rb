module Admin
  module Api
    module V2
      class CancellationOrdersController < ApplicationController
        before_action :verify_token, only: %i[create]

        def create
          shipping = Operations::RequestCancellationShipping.execute(params[:order_id])

          if shipping
            render json: { shipping: { id: shipping.id } }, status: :created
          else
            render status: :internal_server_error
          end
        end
      end
    end
  end
end
