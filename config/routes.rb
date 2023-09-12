Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :subscriptions, only: [:index]
      resources :customers, only: [:index] do 
        # resources :subscriptions, only: [:create, :destroy]
      end
      post "/customers/:customer_id/subscriptions/:subscription_id", to: "customer_subscriptions#create"
      delete "/customers/:customer_id/subscriptions/:subscription_id", to: "customer_subscriptions#destroy"
    end
  end
end
