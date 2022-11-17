class UserRecipe < ActiveRecord::Base 
    belongs_to :user
    has_many :recipes

    # def self.delete_recipe(name)
    #     to_delete = Recipe.all.find do |recipe|
    #         recipe.name.downcase == name.downcase
    #     end
    #     ur_to_delete = UserRecipe.find_by(recipe_id: to_delete.id)
    #     ur_to_delete.delete
    # end


    def self.delete_recipe(recipe_id:, user_id:)
        UserRecipe.find_by(recipe_id: recipe_id, user_id: user_id).delete
        # if user_deleted_recipe != nil 
        #     user_deleted_recipe.delete
        #     return true
        # end
        # return false
    end
end