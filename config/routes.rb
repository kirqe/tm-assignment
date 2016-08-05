Rails.application.routes.draw do
  scope module: :web do
    resources :tasks, only: [:index, :show]
  end
end
