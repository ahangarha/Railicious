Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :recipes, except: [:update] do
    resources :recipe_foods, only: [:create, :destroy]
  end

  resources :foods, only: [:index, :new, :create, :destroy]
  get '/shopping_list', to: 'shopping_list#index' 

  # Defines the root path route ("/")
  get '/public_recipes', to: 'recipes#public'
  root to: "recipes#public"
end
