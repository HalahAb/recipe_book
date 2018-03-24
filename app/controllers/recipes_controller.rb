class RecipesController < ApplicationController
  
  def index
    @recipes = Recipe.all
  end

  def show
     @recipe = Recipe.find(params[:id])
  end
  
  def new

  end

  def create
     @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save! 
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end

  end

  def edit
    @recipe = current_user.recipes.find(params[:id])
  end

  def update
    @recipe= current_user.recipess.find(params[:id])
    @recipe.update(recipe_params)
    redirect_to recipe_path
  end

  def delete
    @recipe = current_user.recipes.find(params[:id])
    if @recipe.destroy
      redirect_to recipes_path
      else
      'This listing does not exist'
    end
  end



private
    def recipe_params
      params.require(:recipe).permit(:title, :description,:ingredients,:prep_time_minutes)
    end
end
