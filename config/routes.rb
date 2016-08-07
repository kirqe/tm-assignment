Rails.application.routes.draw do

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  scope module: :web do
    resources :tasks do
      member do
        put :start
        put :finish
      end
    end#, only: [:index, :show]

    resources :users do
      resources :tasks#, only: [:index, :show, :update]
    end

    namespace :admin do
      resources :users, :tasks
    end

    root 'tasks#index'
  end
end
