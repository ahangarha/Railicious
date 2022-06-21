Rails.application.routes.draw do
  devise_for :users

  resources :foods, only: [:index, :create, :destroy]

  # Defines the root path route ("/")
  # root "articles#index"
end
