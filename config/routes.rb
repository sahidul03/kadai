Rails.application.routes.draw do
  root 'albums#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :albums, only: [:new, :create, :index]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
