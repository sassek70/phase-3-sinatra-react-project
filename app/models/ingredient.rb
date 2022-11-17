class Ingredient < ActiveRecord::Base
    has_many :user_ingredients
    has_many :users, through: :user_ingredients
    has_many :recipe_ingredients
    has_many :recipes, through: :recipe_ingredients
    
    def self.add_ingredient(name:, quantity:, user_id:)
        check_ingredient = Ingredient.find_by("name like ?", name)
        in_stock = true

        if quantity > 0
            in_stock = true
        else
            in_stock =false
        end
        # checks to see if the user added ingredient exists in the Ingredients table, then checks agains the User's list
        # If the new ingredient exists in master list, this method adds it to the user. If it does not exists in master list
        # this methods add ingredient to both tables
        if check_ingredient and UserIngredient.exists?(ingredient_id: check_ingredient) == true
            "Ingredient already on your list"
        elsif check_ingredient and UserIngredient.exists?(ingredient_id: check_ingredient) == false
            UserIngredient.create(user_id: user_id, ingredient_id: check_ingredient.id, quantity: quantity)
            "Ingredient exists, added to user list"
        else
            new_ingredient = Ingredient.create(name: name.titleize)
            UserIngredient.create(user_id: user_id, ingredient_id: new_ingredient.id, quantity: quantity, in_stock: in_stock)
            "Ingredient created and added to user list"
        end
        
    end



end