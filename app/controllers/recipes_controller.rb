class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.where(user_id: current_user.id)
  end

  def show
    if current_user != Recipe.find(params[:id]).user && !Recipe.find(params[:id]).public
      flash[:notice] = 'You are not authorized to access this page'
      redirect_to recipes_path
    end
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
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

  def public
    @recipes = Recipe.public_recipes
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
