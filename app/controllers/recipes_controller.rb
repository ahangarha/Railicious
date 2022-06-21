class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.where(user_id: current_user.id)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to recipes_path
    else
      render 'new'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    return unless @recipe.destroy

    flash[:success] = 'Recipe deleted successfully'
    redirect_to recipes_path

  end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
