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
    recipe_food = RecipeFood.includes(:recipe).find(params[:id])

    recipe = recipe_food.recipe
    # food = recipe.foods.find(params[:id])

    # puts '#'*80
    # puts recipe_food
    if recipe_food.destroy!
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
