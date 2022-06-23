class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!

  def create
    recipe = Recipe.find(params[:recipe_id])
    if recipe.user == current_user
      new_recipe_food = RecipeFood.new(recipe_food_params)
      new_recipe_food.recipe = recipe

      if new_recipe_food.save!
        flash[:notice] = 'Food added successfully.'
      else
        flash[:alert] = 'Failed to add food!'
      end
    else
      flash[:alert] = 'Not authorized!'
    end

    redirect_to recipe_path(recipe)
  end

  def destroy
    recipe_food = RecipeFood.includes(:recipe).find(params[:id])

    recipe = recipe_food.recipe

    if recipe_food.destroy!
      flash['notice'] = 'Food item removed from recipe successfully'
    else
      flash['alert'] = 'Failed to delete the item!'
    end
    redirect_to recipe_path(recipe)
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
