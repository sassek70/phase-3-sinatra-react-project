class UserIngredient < ActiveRecord::Base 
    has_many :ingredients
    belongs_to :user

    # Deletes ingredient from specific User only.
    # def self.delete_ingredient(name, user)
    #     to_delete = Ingredient.all.find do |ingredient|
    #         ingredient.name.downcase == name.downcase
    #     end
    #     ui_to_delete = UserIngredient.find_by(ingredient_id: to_delete.id)
    #     ui_to_delete.delete
    # end


    def self.delete_ingredient(ingredient_id:, user_id:)
        UserIngredient.find_by(ingredient_id: ingredient_id, user_id: user_id).delete
    end

end