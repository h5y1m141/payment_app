module Resources
  module V2
    class OrderResource < Grape::API
      helpers StrongParamsHelpers

      resource :orders do
        desc 'order list'
        get do
          @orders = Order.with_parent.page(params[:page]).per(params[:per_page])
          present @orders, with: Entities::V2::OrderEntity
        end

        desc 'order'
        params do
          requires :id, type: Integer, desc: 'order id'
        end
        get ':id' do
          @order = Order.with_parent.find(params[:id])
          present @order, with: Entities::V2::OrderEntity
        end

        desc 'create order'
        params do
          requires :order, type: Hash do
            requires :customer_id, type: Integer, desc: 'customer id'
            requires :quantity, type: Integer, desc: 'order id'
            requires :amount, type: Integer, desc: 'order id'
          end
        end
        post do
          @order = Operations::CreateOrder.execute(permitted_params[:order])
          present @order, with: Entities::V2::OrderEntity
        end
      end
    end
  end
end
