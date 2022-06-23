class ShoppingListController < ApplicationController
  before_action :authenticate_user!

  def index
    foods = current_user.foods
    @filtered_food = foods.filter { |food| food.recipes.blank? }
    @total_price = @filtered_food.sum(&:price)
  end
end
