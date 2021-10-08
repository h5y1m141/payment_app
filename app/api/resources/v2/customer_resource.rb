module Resources
  module V2
    class CustomerResource < Grape::API
      helpers StrongParamsHelpers

      resource :customers do
        desc 'create customer'
        params do
          requires :customer, type: Hash do
            requires :uid, type: String, desc: 'uid which is generated by Firebase Authentication'
          end
        end
        post do
          @customer = Customer.create(permitted_params[:customer])
          present @customer, with: Entities::V2::CustomerEntity
        end
      end
    end
  end
end