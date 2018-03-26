class AddVerificationStatusToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :verified, :boolean, default: false
  end
end
