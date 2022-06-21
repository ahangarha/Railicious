users = User.create([
  {
    name: 'Mostafa',
    email: 'mostafa@rails.com',
    password: '123123'
  },
  {
    name: 'Muneeb',
    email: 'muneeb@rails.com',
    password: '123123'
  },
])

recipes = Recipe.create([
  {
    name: 'Recipe 1',
    preparation_time: 20,
    cooking_time: 60,
    description: 'Description for food 1',
    public: false,
    user: users.first,
  },
  {
    name: 'Recipe 2',
    preparation_time: 15,
    cooking_time: 20,
    description: 'Description for food 2',
    public: true,
    user: users.first,
  },
  {
    name: 'Recipe 3',
    preparation_time: 5,
    cooking_time: 10,
    description: 'Description for food 3',
    public: true,
    user: users.second,
  },
])

foods = Food.create([
  {
    name: 'Food 1',
    measurement_unit: 'KG',
    price: 3.2,
    user: users.first,
  },
  {
    name: 'Food 2',
    measurement_unit: 'Liter',
    price: 1,
    user: users.first,
  },
  {
    name: 'Food 3',
    measurement_unit: 'Piece',
    price: 0.32,
    user: users.second,
  },
])

recipe_foods = RecipeFood.create!([
  {
    quantity: 1,
    food: foods.first,
    recipe: recipes.first
  },
  {
    quantity: 1.5,
    food: foods.second,
    recipe: recipes.first
  },
  {
    quantity: 5,
    food: foods.third,
    recipe: recipes.second
  },
])