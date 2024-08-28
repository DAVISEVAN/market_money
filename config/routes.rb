Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :markets, only: [:index, :show] do
        resources :vendors, only: [:index]
      end
      resources :vendors, only: [:show, :create, :update, :destroy]
      resources :market_vendors, only: [:create, :destroy], path: 'market_vendors'
    end
  end
end
