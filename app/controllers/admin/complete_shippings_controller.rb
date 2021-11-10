module Admin
  class CompleteShippingsController < Admin::ApplicationController
    def index
      @shippings = Shipping.complete_list
    end
  end
end
