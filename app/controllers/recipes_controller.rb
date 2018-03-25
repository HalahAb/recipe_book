class RecipesController < ApplicationController
  
  def index
    @recipes = Recipe.all
  end

  def show
     @recipe = Recipe.find(params[:id])
  end
  
  def new
    @recipe = Recipe.new
    @recipe.categories.new
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
    @recipe.categories
  end

  def update
    byebug
    @recipe= current_user.recipes.find(params[:id])
    @recipe.update(recipe_params)
    redirect_to recipe_path
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    if @recipe.destroy
      redirect_to recipes_path
      else
      'This listing does not exist'
    end
  end



  def search
    @categories = Category.where(name: params[:category_name])

    @recipes = @categories.map(&:recipe)

    render "index"


    # respond_to do |format|
    #   format.js
    # end
    
  end



private
    def recipe_params
      params.require(:recipe).permit(:title, :description,:ingredients, {recipe_images: []}, :prep_time_minutes, :cooking_time_minutes, categories_attributes: [:id, :_destroy, :name])
    end

    def filtering_params(params)
      params.slice(:category)
    end
end
