require 'rails_helper'

RSpec.describe 'Posts index page', type: :system do
  before do
    driven_by(:rack_test)
    @user = User.create(name: 'admin',
                        email: 'admin@email.com',
                        password: 'password', password_confirmation: 'password')
    @user.save
    @recipe = Recipe.create(user_id: @user.id, name: 'Recipe 1', preparation_time: 10, cooking_time: 20, description: 'This is test recipe and it is very delicious', public: true )
    visit 'users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'admin@email.com'
      fill_in 'Password', with: 'password'
    end
    find_button('Log in').click
  end

  it 'I can browse the public recipes.' do
    expect(page).to have_content('Browse public recipes')
    expect(page).to have_content('Recipe 1')
  end

  it 'I can see the My recipes.' do
    click_link('My Recipes')
    expect(page).to have_content('All your recipes')
    expect(page).to have_content('This is test recipe and it is very delicious')
  end

  it 'I can create new recipes.' do
    click_link('My Recipes')
    click_link('New')
    fill_in 'Name', with: 'Stake'
    fill_in 'Preparation time', with: '30'
    fill_in 'Cooking time', with: '60'
    fill_in 'Description', with: 'stake is very tasty and amazing'
    find_button('Create Recipe').click
    expect(page).to have_content('Stake')
    expect(page).to have_content('stake is very tasty and amazing')
  end

  it 'I can delete recipes.' do
    click_link('My Recipes')
    find_button('Delete').click
    expect(page).to have_content('Recipe deleted successfully')
  end
end