class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  @user = "/user"
  # Find all users
  get "#{@user}" do
    users = User.all
    users.to_json
  end

  #User details
  get "#{@user}/:id"do
    user = User.find(params[:id])
    {message: "This user has #{user.my_recipes.count} recipes and #{user.my_ingredients.count} ingredients"}.to_json
  end

  #Find all recipes for a specific user
  get "#{@user}/:id/recipes" do
    User.find(params[:id]).my_recipes.to_json
  end
  
  #Find all ingredients for a specific user
  get "#{@user}/:id/ingredients" do
    User.find(params[:id]).my_ingredients.to_json
  end

  #Get all ingredients
  get "/ingredients" do
    Ingredient.all.to_json
  end

  #Add new ingredient
  post "#{@user}/:id/ingredients" do
    user = User.find(params[:id])
    Ingredient.add_ingredient(name: params[:name], quantity: params[:quantity], user_id: params[:id]).to_json
    # Ingredient.create(name: params[:name])
    # UserIngredient.create(user_id: user.id, ingredient_id: Ingredient.last.id, quantity: params[:quantity], in_stock: params[:in_stock]).to_json
  end

  #Delete user's ingredient
  delete "#{@user}/:id/ingredients/:ingredient_id" do
    UserIngredient.delete_ingredient(ingredient_id: params[:ingredient_id], user_id: params[:id]).to_json
  end

  #Add new recipe
  post "#{@user}/:id/recipes" do
    user = User.find(params[:id])
    Recipe.add_recipe(name: params[:name], cuisine: params[:cuisine], times_cooked: params[:times_cooked], instructions: params[:instructions], user_id: params[:id]).to_json
  end

  #Delete user's recipe
  delete "#{@user}/:id/recipes/:recipe_id" do
    UserRecipe.delete_recipe(recipe_id: params[:recipe_id], user_id: params[:id]).to_json
    # if user_deleted_recipe 
    #   return user_deleted_recipe.to_json
    # end
    # status 404
  end

  #Update cooked count
  patch "/recipes/:id/cook" do
    user = User.includes(:ingredients).find(params[:user_id])
    recipe = Recipe.includes(:ingredients).find(params[:id])
    can_cook = recipe.can_cook(user.ingredients)
    can_cook ? Recipe.cook_recipe(recipe_id: params[:id]).to_json : "Missing ingredients"
  end

  get "#{@user}/:id/canCook" do
    user = User.includes(:ingredients).find(params[:id])
    available_recipes = Recipe.all.filter do |recipe|
      recipe.can_cook(user.ingredients)
    end    
    available_recipes.to_json
  end

end
