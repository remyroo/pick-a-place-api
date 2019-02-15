Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'signup', to: 'users#create'
      post 'login', to: 'user_token#create'

      resources :users, only: [:index, :update, :destroy]
    end
  end
end
