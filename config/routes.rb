Rails.application.routes.draw do
  root 'albums#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :albums, only: [:new, :create, :index] do
    collection do
      post 'tweet'
    end
  end

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'tweeter_auth', to: 'sessions#tweeter_auth', as: 'tweeter_auth'
  get 'oauth/callback', to: 'sessions#callback'
end
