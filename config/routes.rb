Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  scope module: :web do
    namespace :admin do
      namespace :dashboard do
        resources :users
        resources :tasks
      end
    end

    scope module: :user do
      namespace :dashboard do
        resources :users, only: [] do
          resources :tasks, only: [:index, :new, :create, :show]
        end
        resources :tasks
      end
    end

    resources :tasks, only: [] do
      member do
        put :start
        put :finish
      end
    end

    root "tasks#index"
  end

end
