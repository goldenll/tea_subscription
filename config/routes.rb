Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :subscriptions, only: [:index]
      resources :customers, only: [:index] do 
        # resources :subscriptions, only: [:create, :update, :destroy]
      end
      post "/customers/:customer_id/subscriptions/:subscription_id", to: "customer_subscriptions#create"
      patch "/customers/:customer_id/subscriptions/:subscription_id", to: "customer_subscriptions#update"
      delete "/customers/:customer_id/subscriptions/:subscription_id", to: "customer_subscriptions#destroy"
    end
  end
end
