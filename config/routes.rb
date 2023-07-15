Rails.application.routes.draw do
  get 'sessions/new'
  resources :tasks
  root to: 'tasks#index'
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]

  namespace :admin do
   resources :users
  end
  #post '/admin/users/new', to: 'admin/users#create'
end
