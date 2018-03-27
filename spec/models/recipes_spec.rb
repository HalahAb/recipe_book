require 'rails_helper'

RSpec.describe Recipe, type: :model do

  context "Presence validation: " do
      describe "title" do
        it "does not save recipes without a title" do
          recipe = Recipe.new
          recipe.valid?
          expect(recipe.errors[:title]).to be_present
        end

        it "does not have an error when a recipe has a title" do
          recipe = Recipe.new(title: 'New recipe')
          recipe.valid?
          expect(recipe.errors[:title]).to_not be_present
        end

      end

      describe "description" do
        it "does not save recipes without a description" do
          recipe = Recipe.new
          recipe.valid?
          expect(recipe.errors[:description]).to be_present
        end

        it "does not have an error when a recipe has a description" do
          recipe = Recipe.new(description: 'bake in oven')
          recipe.valid?
          expect(recipe.errors[:description]).to_not be_present
        end
      end

      describe "ingredients" do
        it "does not save recipes without ingredients" do
          recipe = Recipe.new
          recipe.valid?
          expect(recipe.errors[:ingredients]).to be_present
        end

        it "does not have an error when a recipe has a ingredients" do
          recipe = Recipe.new(ingredients: 'eggs')
          recipe.valid?
          expect(recipe.errors[:ingredients]).to_not be_present
        end
      end

      describe "cooking_time_minutes" do
        it "does not save recipes without cooking_time_minutes" do
          recipe = Recipe.new
          recipe.valid?
          expect(recipe.errors[:cooking_time_minutes]).to be_present
        end

        it "does not have an error when a recipe has a cooking_time_minutes" do
          recipe = Recipe.new(cooking_time_minutes: '5')
          recipe.valid?
          expect(recipe.errors[:cooking_time_minutes]).to_not be_present
        end



      describe "prep_time_minutes" do
        it "does not save recipes without prep_time_minutes" do
          recipe = Recipe.new
          recipe.valid?
          expect(recipe.errors[:prep_time_minutes]).to be_present
        end

        it "does not have an error when a recipe has a prep_time_minutes" do
          recipe = Recipe.new(prep_time_minutes: '5')
          recipe.valid?
          expect(recipe.errors[:prep_time_minutes]).to_not be_present
        end
      end
    end
  end

  context "Numericallity validation: " do

    describe "cooking_time_minutes" do
      it "does not save recipes with non-numerical cooking_time_minutes" do
        recipe = Recipe.new(cooking_time_minutes: "15 minutues")
        recipe.valid?
        expect(recipe.errors[:cooking_time_minutes]).to eq(["is not a number"])
      end

      it "does not have an error when a recipe has a numerical cooking_time_minutes" do
        recipe = Recipe.new(cooking_time_minutes: 5)
        recipe.valid?
        expect(recipe.errors[:cooking_time_minutes]).to_not eq(["is not a number"])
      end
    end



    describe "prep_time_minutes" do
      it "does not save recipes with a non-numerical prep_time_minutes" do
        recipe = Recipe.new(prep_time_minutes: "15 minutues")
        recipe.valid?
        expect(recipe.errors[:prep_time_minutes]).to eq(["is not a number"])
      end

      it "does not have an error when a recipe has a numerical prep_time_minutes" do
        recipe = Recipe.new(prep_time_minutes: 15)
        recipe.valid?
        expect(recipe.errors[:prep_time_minutes]).to_not eq(["is not a number"])
      end
    end
  end


  context "Verify " do
    describe "verfied" do
      it "creates a default unverified recipe on creation" do
        recipe = Recipe.new(title: "Cool recipe", description: "Easy to follow steps", prep_time_minutes: 5, cooking_time_minutes: 10)
        recipe.save
        expect(recipe.verified).to eq(false)
      end
    end
   
    describe "verify" do
      it "verifies an unverified recipe" do
        recipe = Recipe.new(title: "Cool recipe", description: "Easy to follow steps", prep_time_minutes: 5, cooking_time_minutes: 10)
        recipe.save
        recipe.verify
        expect(recipe.verified).to eq(true)
      end
    end

    describe "unverify" do
      it "verifies an unverified recipe" do
        recipe = Recipe.new(title: "Cool recipe", description: "Easy to follow steps", prep_time_minutes: 5, cooking_time_minutes: 10)
        recipe.save
        recipe.verify
        recipe.unverify
        expect(recipe.verified).to eq(false)
      end
    end
  end

  context "duration " do
    describe "duration" do
      it "adds prep_time_minutes and cooking_time_minutes" do
        recipe = Recipe.new(title: "Cool recipe", description: "Easy to follow steps", prep_time_minutes: 5, cooking_time_minutes: 10)
        recipe.save
        expect(recipe.duration).to eq(15)
      end

      it "should return zero when prep_time_minutes and cooking_time_minutes are nil" do
        recipe = Recipe.new(title: "Cool recipe", description: "Easy to follow steps")
        expect(recipe.duration).to eq(0)
      end
    end

  end
  
end