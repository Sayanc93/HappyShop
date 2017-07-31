Rails.application.routes.draw do
  scope :api, module: 'api', defaults: { format: 'json' } do
    namespace :v1 do
      resources :products
      resources :categories
    end
  end

  get '*path', to: "application#fallback_index_html", constraints: ->(request) do
    !request.xhr?
  end
end
