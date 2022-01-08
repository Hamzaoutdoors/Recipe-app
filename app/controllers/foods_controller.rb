class FoodsController < ApplicationController
  load_and_authorize_resource

  def index
    @current_user = current_user
    @foods = current_user.foods.all.includes(:recipe_foods)
  end

  def new
    @food = Food.new
    @current_user = current_user
  end

  def create
    @food = current_user.foods.new(food_params)
    if @food.save
      redirect_to foods_url, notice: 'Food was successfully created.'
    else
      flash[:alert] = 'Error: Food is not published'
    end
  end

  def destroy
    @food.destroy
    redirect_to foods_url, notice: 'Food was successfully destroyed.'
  end

  private

  def set_food
    @food = Food.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end
