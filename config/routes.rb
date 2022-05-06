Rails.application.routes.draw do
  resources :comments, only: [:index, :show]
  resources :posts, only: [:index, :show]

  namespace :snowflake do
    resources :comments, only: [:index, :show]
    resources :posts, only: [:index, :show]
  end
end
