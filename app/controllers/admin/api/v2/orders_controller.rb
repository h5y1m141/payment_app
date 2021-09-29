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
          params.permit(:total_price, payment_method: [:id], cart_items: [:subTotal, :quantity, product: [:id, :name, :price]])
        end
      end
    end
  end
end
