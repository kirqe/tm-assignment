Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  scope module: :web do
    # resources :tasks, only: [:index, :show, :new, :create] do
    #   member do
    #     put :start
    #     put :finish
    #   end
    # end
    #
    # resources :users do
    #   resources :tasks, only: [:index, :show, :update]
    # end

    namespace :admin do
      namespace :dashboard do
        resources :users
        resources :tasks
      end
    end

    scope module: :user do
      namespace :dashboard do
        resources :tasks
        resources :users do
          resources :tasks do
            member do
              put :start
              put :finish
            end
          end
        end
      end
    end


  end
end
