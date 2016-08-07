Rails.application.routes.draw do

  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  scope module: :web do
    resources :tasks, only: [:index, :show] do
      member do
        put :start
        put :finish
      end
    end

    resources :users do
      resources :tasks, only: [:index, :show, :update]
    end

    namespace :admin do
      resources :users, :tasks
    end

    root 'tasks#index'
  end
end
