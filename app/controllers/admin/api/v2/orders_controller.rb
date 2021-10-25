module Admin
  module Api
    module V2
      class OrdersController < ApplicationController
        before_action :verify_token, only: %i[index show create]

        def index
          @orders = Order.with_parent.all
        end

        def show
          @order = Order.with_parent.find(params[:id])
        end

        def create
          @order = Operations::CreateOrder.execute(order_params)

          render :show
        end

        private

        def order_params
          params.permit(:uid, :total_price, payment_method: [:id, card: [:brand, :last4, :exp_month, :exp_year]], cart_items: [:subTotal, :quantity, product: [:id, :name, :price]])
        end

        def verify_token
          if params[:id_token].blank?
            render status: 400, json: { status: 400, message: 'Bad request' }
          else
            result = AuthToken.verify(params[:id_token])
            render status: 401, json: { status: 401, message: 'Unauthorized' } if result['uid'].empty?
          end
        end
      end
    end
  end
end
