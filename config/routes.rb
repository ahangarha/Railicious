Rails.application.routes.draw do
  devise_for :users
  resources :recipes, except: [:update] do
    resources :recipe_foods, only: [:create, :destroy]
  end

  resources :foods, only: [:index, :new, :create, :destroy]

  # Defines the root path route ("/")
  get '/public_recipes', to: 'recipes#public'
  root to: "recipes#public"
end
