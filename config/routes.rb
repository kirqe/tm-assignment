Rails.application.routes.draw do
  scope module: :web do
    scope module: :tasks do
      resources :tasks, only: [:index, :show]
    end
  end
end
