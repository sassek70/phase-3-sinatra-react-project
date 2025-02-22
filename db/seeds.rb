puts "🌱 Seeding spices..."

User.create(name: "Jimmy John")
User.create(name: "Johnny Jim")
User.create(name: "J J")
User.create(name: "Jen")
User.create(name: "Jeremy")
User.create(name: "Joe")
User.create(name: "Jack")

Cuisine.create(name: "Italian")
Cuisine.create(name: "Mexican")
Cuisine.create(name: "Irish")
Cuisine.create(name: "Thai")
Cuisine.create(name: "Japanese")

Recipe.create(name: "Gravy Carrot", times_cooked:5, instructions:"Pour gravy on carrot", cuisine_id: rand(1..5))
Recipe.create(name: "Baked Potato", times_cooked:5, instructions:"Bake in oven", cuisine_id: rand(1..5))
Recipe.create(name: "Loaded Potato", times_cooked:1, instructions:"Bake potato, add peppers and gravy", cuisine_id: rand(1..5))
Recipe.create(name: "Plain Carrot", times_cooked:5, instructions:"Just eat it", cuisine_id: rand(1..5))
Recipe.create(name: "Gravy", times_cooked:6, instructions:"Cook in pot, then drink", cuisine_id: rand(1..5))

Ingredient.create(name: "Carrot")
Ingredient.create(name: "Green Pepper")
Ingredient.create(name: "Potato")
Ingredient.create(name: "Gravy")
Ingredient.create(name: "Honey")
Ingredient.create(name: "Habenero")
Ingredient.create(name: "Pickle")
Ingredient.create(name: "Jalapeno")
Ingredient.create(name: "Bread")
Ingredient.create(name: "Beer")
Ingredient.create(name: "Ketchup")
Ingredient.create(name: "Beef")
Ingredient.create(name: "Chicken")
Ingredient.create(name: "Black Beans")
Ingredient.create(name: "Peas")
Ingredient.create(name: "Corn")

30.times {UserIngredient.create(user_id: rand(1..7), ingredient_id: rand(1..16), quantity: rand(1..10), in_stock: true)}

20.times {RecipeIngredient.create(ingredient_id: rand(1..16), recipe_id: rand(1..5))}

15.times {UserRecipe.create(user_id: rand(1..7), recipe_id: rand(1..5))}






puts "✅ Done seeding!"
