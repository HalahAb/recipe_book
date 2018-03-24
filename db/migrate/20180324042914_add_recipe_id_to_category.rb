class AddRecipeIdToCategory < ActiveRecord::Migration[5.1]
  def change
  add_reference :categories, :recipe, foreign_key: true, index: true
  end
end
