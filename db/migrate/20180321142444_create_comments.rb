class CreateComments < ActiveRecord::Migration[5.1]
  def change

    create_table :comments do |t|
      t.text :description, null: false
      t.references  :user, foreign_key: true, index: true
      t.references :recipe, forign_key:true, index: true
      t.timestamps
    end
  
  end

end
