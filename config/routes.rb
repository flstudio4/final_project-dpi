Rails.application.routes.draw do
  get '/dashboard', to: 'dashboard#home'
  get '/welcome', to: 'static_pages#welcome'
  get '/profiles', to: 'profiles#index'
  get '/profiles/:id', to: 'profiles#show'
  get '/search', to: 'profiles#search'

  devise_for :users

  # root route for authenticated users
  authenticated :user do
    root "profiles#index", as: :authenticated_root
  end

  # landing page if you are not logged in
  root "static_pages#welcome"

  resources :blocks, only: [:index, :create, :destroy]
  resources :favorites, only: [:index, :create, :destroy]
  resources :messages
  resources :chats, only: [:index, :create, :destroy]

  resources :chats do
    resources :messages
  end

end
# ------------------------------------------------------------------------------------------------------------------------
# https://gist.github.com/withoutwax/46a05861aa4750384df971b641170407  Helpful resource for messing with devise controller
# ------------------------------------------------------------------------------------------------------------------------
#