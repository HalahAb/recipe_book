class CommentsController < ApplicationController
  
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.new(user_id: current_user.id, description: params[:comment][:description])
    
    if @comment.save
    redirect_to recipe_path(@recipe)
    end
  end




end
