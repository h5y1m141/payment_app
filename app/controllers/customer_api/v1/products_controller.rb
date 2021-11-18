module CustomerApi
  module V1
    class ProductsController < ApplicationController
      def index
        @products = Product.includes(:product_stock).all
      end

      def show
        @product = Product.find(params[:id])
      end
    end
  end
end
