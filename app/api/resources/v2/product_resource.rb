module Resources
  module V2
    class ProductResource < Grape::API
      resource :products do
        desc 'product list'
        get do
          @products = Product.page(params[:page]).per(params[:per_page])
          present @products, with: Entities::V2::ProductEntity
        end

        desc 'product'
        params do
          requires :id, type: Integer, desc: 'product id'
        end
        get ':id' do
          @product = Product.find(params[:id])
          present @product, with: Entities::V2::ProductEntity
        end
      end
    end
  end
end
