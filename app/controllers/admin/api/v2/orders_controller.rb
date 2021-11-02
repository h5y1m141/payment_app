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
          params.permit(
            :uid,
            :total_price,
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

        def verify_token
          render_bad_request('ID Tokenが設定されていません') if params[:id_token].blank?

          result = AuthToken.verify(params[:id_token])
          render_unauthorized if result['uid'].empty?
        end
      end
    end
  end
end
