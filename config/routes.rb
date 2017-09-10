Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'application#root'

  resources :bundles

  namespace :api do
    namespace :v1 do
      jsonapi_resources :bundles
      jsonapi_resources :products
      jsonapi_resources :subscription_periods
    end
  end
end
