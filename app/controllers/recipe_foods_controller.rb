class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!

  def create
    recipe = Recipe.find(params[:recipe_id])
    new_recipe_food = RecipeFood.new(recipe_food_params)
    new_recipe_food.recipe = recipe

    new_recipe_food.save!
    redirect_to recipe_path(recipe)
  end

  def destroy
    recipe = Recipe.includes(:foods).find(params[:recipe_id])
    food = recipe.foods.find(params[:id])

    if RecipeFood.where(recipe:, food:).destroy_all
      flash['notice'] = 'Food item removed from recipe successfully'
      redirect_to recipe_path(recipe)
    else
      flash.now['alert'] = 'Failed to delete the item!'
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end