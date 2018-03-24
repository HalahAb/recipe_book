class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.text :ingredients
      t.integer :cooking_time_minutes
      t.integer :prep_time_minutes
      t.json :recipe_images
      t.references :user, forign_key:true, index: true


      t.timestamps
    end
  end
end
