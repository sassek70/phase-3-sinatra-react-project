class Recipe < ActiveRecord::Base
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients
    belongs_to :user_recipe
    has_many :users, through: :user_recipe
    belongs_to :cuisine


    def self.add_recipe(name:, cuisine:, times_cooked:, instructions:, user_id:)
        times_cooked = times_cooked || 0

        check_cuisine = Cuisine.find_by("name like ?", cuisine) || Cuisine.create(name: cuisine.titleize)
        # check_cuisine ||= Cuisine.create(name: cuisine.titleize)
        check_recipe = Recipe.find_by("name like ?", name)

        # checks to see if the user added recipe exists in the Recipes table, then checks agains the User's list
        # If the new recipe exists in master list, this method adds it to the user. If it does not exists in master list
        # this methods add recipe to both tables
        if check_recipe and UserRecipe.exists?(recipe_id: check_recipe) == true
            "Recipe already on your list"
        elsif check_recipe and UserRecipe.exists?(recipe_id: check_recipe) == false
            UserRecipe.create(user_id: user_id,recipe_id: check_recipe.id)
            "Recipe exists, added to user list"
        else
            new_recipe = Recipe.create(name: name.titleize, cuisine_id: check_cuisine.id, times_cooked: times_cooked, instructions: instructions)
            UserRecipe.create(user_id: user_id, recipe_id: new_recipe.id)
            "Recipe created and added to user list"
        end
    end

    def self.cook_recipe(recipe_id:)
        recipe = Recipe.find(recipe_id)
        recipe.update(times_cooked: recipe.times_cooked + 1)
        recipe
    end

    def can_cook(user_ingredients)
        self.ingredients.each do |ingredient|
            found_ingredient = user_ingredients.find_by(id: ingredient.id)
            if found_ingredient == nil 
                return false
            end
        end
        return true
    end


end