module Admin
  module Api
    module V2
      class OrdersController < ApplicationController
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
          params.require(:order).permit(:user_id, :product_id, :quantity, :amount)
        end
      end
    end
  end
end
