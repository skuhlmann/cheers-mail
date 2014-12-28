Rails.application.routes.draw do

  root 'home#index'

  get '/admin', to: 'admin/base_admin#index', as: :admin_index

  namespace :admin do
    resources :users, only: [:destroy, :update, :create, :new, :edit, :show]
    resources :episodes, :subscriptions
  end

  resources :subscriptions, only: [:create]

  get 'unsubscribe',     to: 'subscriptions#unsubscribe'
  delete '/unsubscribe', to: 'subscriptions#destroy'

  get 'login',      to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
 end
