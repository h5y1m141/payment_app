module Admin
  class CompleteShippingsController < Admin::ApplicationController
    def index
      @shippings = ShippingState.shipping_complete
    end
  end
end
