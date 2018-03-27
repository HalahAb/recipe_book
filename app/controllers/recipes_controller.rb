class RecipesController < ApplicationController
  before_action :authorize, except: [:index, :show]  
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

  def list_unverified
    if current_user.admin?
      @recipes = Recipe.where(verified: false)
      render "index"
    else
      redirect_to recipes_path
    end
    
  end

  def verify
    @recipe = current_user.recipes.find(params[:id])
    @recipe.verify 
    redirect_to recipes_path
  end

  def unverify
    @recipe = current_user.recipes.find(params[:id])
    @recipe.unverify
    redirect_to recipes_path
  end

  def get_ingredients
    @recipe= Recipe.find(params[:id])
    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new ENV['account_sid'], ENV['auth_token']

    from = '+19104058440 ' # Your Twilio number
    to = params[:number] # Your mobile phone number

    @client.api.account.messages.create(
    from: from,
    to: to,
    body: @recipe.ingredients
    )

    redirect_to recipe_path
  end

private
    def recipe_params
      params.require(:recipe).permit(:title, :description,:ingredients, {recipe_images: []}, :prep_time_minutes, :cooking_time_minutes, categories_attributes: [:id, :_destroy, :name])
    end

    def filtering_params(params)
      params.slice(:category)
    end
end
