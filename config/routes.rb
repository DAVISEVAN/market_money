Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :markets, only: [:index] do
        resources :vendors, only: [:index], controller: 'vendors'
      end
    end
  end
end
