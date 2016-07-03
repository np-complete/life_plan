Rails.application.routes.draw do
  use_doorkeeper do
    controllers applications: 'oauth/applications'
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  as :user do
    get 'sign_out', to: 'devise/sessions#destroy'
  end

  resources :channels, only: [:index, :create, :update, :destroy]
  resources :programs, only: [:index]
  resources :titles, only: [:index, :update, :destroy] do
    match ':initial', to: 'titles#index', on: :collection, via: :get, as: :initial
  end
  resource :api, only: [:show]

  namespace :api do
    get '/v1', to: 'documents#v1'
    namespace :v1, defaults: { format: 'json' } do
      resources :programs, only: [:index]
    end
  end

  root to: 'programs#index'
end
