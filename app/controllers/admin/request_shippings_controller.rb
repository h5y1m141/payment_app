module Admin
  class RequestShippingsController < Admin::ApplicationController
    def index
      @shippings = ShippingState.shipping_request
    end

    def create
      shipping_state = ShippingState.find_by(
        order_id: request_shipping_params[:order_id]
      )

      if shipping_state.ship_ready!
        flash[:notice] = '受付注文処理に成功しました'
      else
        flash[:alert] = '受付注文処理に失敗しました'
      end

      redirect_to admin_request_shippings_path
    end

    private

    def request_shipping_params
      params.permit(:order_id)
    end
  end
end
