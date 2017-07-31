Rails.application.routes.draw do
  scope :api, module: 'api', defaults: { format: 'json' } do
    namespace :v1 do
      resources :products
      resources :categories
    end
  end
end
