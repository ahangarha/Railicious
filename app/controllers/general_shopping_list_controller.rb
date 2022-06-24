class GeneralShoppingListController < ApplicationController
  before_action :authenticate_user!

  def index
    foods = Food.includes(:recipes).where(user: current_user)
    @filtered_food = foods.filter { |food| food.recipes.blank? }
    @total_price = @filtered_food.sum(&:price)
  end
end
