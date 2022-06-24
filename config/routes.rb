Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :recipes, except: [:update] do
    resources :recipe_foods, only: [:create, :destroy]
  end

  resources :foods, only: [:index, :new, :create, :destroy]
  get '/general_shopping_list', to: 'general_shopping_list#index' 

  # Defines the root path route ("/")
  get '/public_recipes', to: 'recipes#public'
  root to: "recipes#public"
end
