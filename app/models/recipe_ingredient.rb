class RecipeIngredient < ActiveRecord::Base 
    belongs_to :ingredient
    has_many :recipes

    def self.recipe_ingredients(recipe)
        recipe_ingredients = UserRecipe.where("recipe_id = ?", recipe.id)
        recipe_ingredients.map do |ingredient|
            Ingredient.where("id = ?", ingredient.id)
        end
    end

end