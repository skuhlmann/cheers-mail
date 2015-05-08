Rails.application.routes.draw do

  root 'home#index'

  get '/admin', to: 'admin/base_admin#index', as: :admin_index
  post '/weekly_email/:id', to: 'admin/subscriptions#weekly_email', as: :weekly_email

  namespace :admin do
    resources :users, only: [:destroy, :update, :create, :new, :edit, :show]
    resources :episodes, :subscriptions, :series
    resources :series_request, only: [:update]
  end

  resources :subscriptions, only: [:create]

  get 'unsubscribe',     to: 'subscriptions#unsubscribe'
  delete '/unsubscribe', to: 'subscriptions#destroy'

  get 'login',      to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
 end
