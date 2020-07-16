Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resources :merchant, only: [:index], controller: "item_merchant"
      end
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/most_revenue', to: 'business_intel#index'
      end
      resources :merchants, only: [:index, :show, :create, :update, :destroy] do
        # get '/find', to: 'search#show'
        # get '/find_all', to: 'search#index'
        resources :items, only: [:index], controller: "merchant_items"
      end
    end
  end
end
