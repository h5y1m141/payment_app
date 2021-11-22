module CustomerApi
  module V1
    class OrdersController < ApplicationController
      before_action :verify_token, only: %i[index show create]

      def index
        @orders = @current_customer.orders.sorted
      end

      def show
        @order = Order.with_parent.find(params[:id])
      end

      def create
        @order = CreateOrderAndAdjustProductStock.execute(order_params)

        render :show
      end

      private

      def order_params
        params.permit(
          :uid,
          :total_price,
          :shipping_address_id,
          payment_method: [
            :id,
            { card: %i[brand last4 exp_month exp_year] }
          ],
          cart_items: [
            :subTotal,
            :quantity,
            {
              product: %i[id name price]
            }
          ]
        )
      end
    end
  end
end
