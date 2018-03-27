require "rails_helper"

feature "recipes" do
  scenario "User posts a recipe" do
    user = User.create(email: 'example@email.com', password_digest: 'welcome')
    ApplicationController.any_instance.stub(:current_user) { user }

    visit "recipes/new"
    fill_in "recipe_title", with: "Mac and Cheese"
    fill_in "recipe_categories_attributes_0_name", with: "Vegiterian"

    fill_in "recipe_prep_time_minutes", with: "5"
    fill_in "recipe_cooking_time_minutes", with: "10"
    fill_in "recipe_ingredients", with: "Frozen mac and cheese"
    fill_in "recipe_description", with: "Heat in microwave for 7 minutes."

    click_button "Submit your recipe"

    expect(page).to have_text "Mac and Cheese"
  end
end