require 'rails_helper'

RSpec.describe 'Posts index page', type: :system do
  before do
    driven_by(:rack_test)
    @user = User.create(name: 'admin',
                        email: 'admin@email.com',
                        password: 'password', password_confirmation: 'password')
    @user.save
    @recipe = Recipe.create(user_id: @user.id, name: 'Recipe 1', preparation_time: 10, cooking_time: 20,
                            description: 'This is test recipe and it is very delicious', public: true)
    visit 'users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'admin@email.com'
      fill_in 'Password', with: 'password'
    end
    find_button('Log in').click
  end

  it 'I can see the shopping list.' do
    click_link('Shopping List')
    expect(page).to have_content('General Shopping List')
    expect(page).to have_content('Total number of foods:')
    expect(page).to have_content('Total price:')
    expect(page).to have_content('No items found!')
  end
end
