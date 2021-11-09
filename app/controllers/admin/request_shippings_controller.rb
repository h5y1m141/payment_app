module Admin
  class RequestShippingsController < Admin::ApplicationController
    def index
      @shippings = Shipping.request_list
    end

    def create
      @shipping = Shipping.create(
        order_id: request_shipping_params[:order_id],
        status: Shipping.statuses[:shipping_in_ready]
      )
      if @shipping
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
