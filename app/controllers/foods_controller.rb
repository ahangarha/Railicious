class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = Food.all
  end

  def destroy
    food = Food.find(params[:id])
    return unless food.present? && food.user == current_user

    food.destroy!
    redirect_to foods_path
  end
end
