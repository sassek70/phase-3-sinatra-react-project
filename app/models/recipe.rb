class Recipe < ActiveRecord::Base
    has_many :recipe_ingredients
    belongs_to :user_recipe
    has_many :users, through: :user_recipe
    belongs_to :cuisine


    def self.add_recipe(name, cuisine, times_cooked = 0, instructions, user)
        check_recipe = Recipe.find_by("name like ?", name)

        # checks to see if the user added recipe exists in the Recipes table, then checks agains the User's list
        # If the new recipe exists in master list, this method adds it to the user. If it does not exists in master list
        # this methods add recipe to both tables
        if check_recipe and UserRecipe.exists?(recipe_id: check_recipe) == true
            "Recipe already on your list"
        elsif check_recipe and UserRecipe.exists?(recipe_id: check_recipe) == false
            UserRecipe.create(user_id: user_id, recipe_id: check_recipe.id, quantity: quantity)
            "Recipe exists, added to user list"
        else
            new_recipe = Recipe.create(name: name.titleize)
            UserRecipe.create(user_id: user_id, recipe_id: new_recipe.id, quantity: quantity, in_stock: in_stock)
            "Recipe created and added to user list"
        end
    end

end