class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[public show]

  def index
    @recipes = Recipe.where(user_id: current_user.id)
  end

  def show
    @recipe = Recipe.includes(:foods).find(params[:id])
    if !@recipe.public && current_user != @recipe.user
      if user_signed_in?
        flash[:notice] = 'You are not authorized to access this page'
        redirect_to recipes_path
      else
        flash[:notice] = 'You must be logged in to access this page'
        redirect_to new_user_session_path
      end
    else
      @recipe
    end
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

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
