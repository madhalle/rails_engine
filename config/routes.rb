Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :show, :create]
    end
  end
end

# namespace :merchants do
#   get 'search_controller/show'
# end
