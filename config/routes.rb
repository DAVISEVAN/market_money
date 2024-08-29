Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get '/markets/:id/nearest_atms', to: 'markets#nearest_atms'
      get '/markets/search', to: 'markets#search'
      resources :markets, only: [:index, :show] do
        resources :vendors, only: [:index]
      end
      resources :vendors, only: [:show, :create, :update, :destroy]
      
      delete '/market_vendors', to: 'market_vendors#destroy'
      resources :market_vendors, only: [:create], path: 'market_vendors'
    end
  end
end
