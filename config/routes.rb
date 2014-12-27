Rails.application.routes.draw do

  root 'episodes#index'

  resources :users, path: '/admin/users'

  resources :episodes, only: [:index]

  get 'login',     to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
 end
