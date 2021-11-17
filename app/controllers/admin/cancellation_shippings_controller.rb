module Admin
  class CancellationShippingsController < Admin::ApplicationController
    def index
      @shippings = ShippingState.cancellation_request
    end

    def create
      @shipping = FixCancellationShipping.execute(
        cancellation_shipping_params[:order_id].to_i
      )
      if @shipping
        flash[:notice] = '注文のキャンセルを実行しました'
      else
        flash[:alert] = '注文のキャンセルに失敗しました'
      end

      redirect_to admin_cancellation_shippings_path
    end

    private

    def cancellation_shipping_params
      params.permit(:order_id)
    end
  end
end
