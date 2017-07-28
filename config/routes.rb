Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope :api, module: 'api' do
    namespace :v1 do
      resources :products
      resources :categories
    end
  end
end
