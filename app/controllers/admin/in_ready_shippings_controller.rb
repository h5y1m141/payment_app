module Admin
  class InReadyShippingsController < Admin::ApplicationController
    def index
      @shippings = ShippingState.shipping_in_ready
    end

    def create
      shipping_state = ShippingState.find_by(
        order_id: in_ready_shipping_params[:order_id]
      )

      if shipping_state.ship_complete!
        flash[:notice] = '出荷処理に成功しました'
      else
        flash[:alert] = '出荷処理に失敗しました'
      end

      redirect_to admin_in_ready_shippings_path
    end

    private

    def in_ready_shipping_params
      params.permit(:order_id)
    end
  end
end
