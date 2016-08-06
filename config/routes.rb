Rails.application.routes.draw do

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  scope module: :web do
    resources :tasks, only: [:index, :show]
    root 'tasks#index'
  end
end
