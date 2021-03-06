Rails.application.routes.draw do
  namespace :admin do
    namespace :api do
      namespace :v1 do
        post "/graphql", to: "graphql#execute"
      end
    end

    resources :products
    resources :orders, only: %i[index show]
    resources :order_items, only: %i[index show]
    resources :customers, only: %i[index show]
    resources :request_shippings, only: %i[index create]
    resources :in_ready_shippings, only: %i[index create]
    resources :cancellation_shippings, only: %i[index create]
    resources :complete_shippings, only: %i[index]
    resources :shipping_addresses, only: %i[index show]

    get    '/',    to: 'firebase_sessions#new'
    post   '/login',    to: 'sessions#create'
    delete '/logout',   to: 'sessions#destroy'
  end

  namespace :customer_api do
    namespace :v1, defaults: { format: :json } do
      resources :products, only: %i[index show]
      resources :orders, only: %i[index show create]
      resources :cancellation_orders, only: %i[create]
      resources :customers, only: %i[show create]
      resources :customer_payment_methods, only: %i[index]
      resources :customer_shipping_addresses, only: %i[index]
    end
  end

  resources :products, only: [:index]

  # mount Api => '/'
  # mount GrapeSwaggerRails::Engine => '/v2/docs'
end
