class ShoppingListController < ApplicationController
  def index
    foods = current_user.foods
    @filtered_food = foods.filter{|food| food.recipes.blank?}
  end
end
