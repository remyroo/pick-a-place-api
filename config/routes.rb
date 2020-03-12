Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    scope module: :v1, constraints: ApiVersion.new('v1', true) do
      post 'signup', to: 'users#create'
      post 'login', to: 'user_token#create'

      resources :users, only: [:index, :update, :destroy]
      get 'search', to: 'venues#search'
    end
  end
end
