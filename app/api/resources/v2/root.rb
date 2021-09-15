module Resources
  module V2
    class Root < Grape::API
      version 'v2'
      format :json
      content_type :json, 'application/json'

      mount Resources::V2::ProductResource
      mount Resources::V2::OrderResource

      add_swagger_documentation(
        doc_version: '1.0.0',
        info: {
          title: 'payment-app-api',
          description: 'PaymentAppのREST APIドキュメント'
        }
      )
    end
  end
end
