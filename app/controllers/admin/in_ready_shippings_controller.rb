module Admin
  class InReadyShippingsController < Admin::ApplicationController
    def index
      @shippings = Shipping.in_ready_list
    end

    def create
      @shipping = Shipping.create(
        order_id: in_ready_shipping_params[:order_id],
        status: Shipping.statuses[:shipping_complete]
      )
      if @shipping
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
