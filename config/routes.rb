Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :show, :create, :update, :destroy]
      resources :merchants, only: [:index, :show, :create, :update, :destroy] do
        resources :items, only: [:index], controller: "merchant_items"
      end
    end
  end
end

# namespace :merchants do
#   get 'search_controller/show'
# end
