class CommentsController < ApplicationController
  
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.new(user_id: current_user.id, description: params[:comment][:description])
    
    @comment.save

    respond_to do |format|
      format.js
    end
  end
end
