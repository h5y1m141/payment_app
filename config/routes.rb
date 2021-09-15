Rails.application.routes.draw do
  namespace :admin do
    namespace :api do
      namespace :v1 do
        post "/graphql", to: "graphql#execute"
      end
      namespace :v2, defaults: { format: :json } do
        resources :products
        resources :orders
      end
    end

    resources :products
    resources :payments
    resources :payment_methods
    resources :orders
    resources :users
    resources :user_profiles
    resources :user_credit_cards
    resources :payment_customers

    get    '/',    to: 'firebase_sessions#new'
    post   '/login',    to: 'sessions#create'
    delete '/logout',   to: 'sessions#destroy'
  end

  resources :products

  mount Api => '/'
  mount GrapeSwaggerRails::Engine => '/v2/docs'
end
