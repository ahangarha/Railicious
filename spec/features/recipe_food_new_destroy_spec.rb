require 'rails_helper'

describe 'In the recipe#show page', type: :feature do
  before :each do
    User.create!(name: 'Ali', email: 'ali@example.com', password: '123456')
    Food.create!(user: User.first, name: 'Potato', measurement_unit: 'KG', price: 1)
    Recipe.create!(user: User.first, name: 'Recipe1')

    visit new_user_session_path
    fill_in 'Email', with: 'ali@example.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  it 'there is a form' do
    visit recipe_path(Recipe.first)
    expect(page).to have_field('Quantity')
  end

  it 'we can add a food to the recipe' do
    visit recipe_path(Recipe.first)

    fill_in 'Quantity', with: '5'
    select 'Potato'
    click_button 'Add'

    within 'table' do
      expect(page).to have_content 'Potato'
    end
  end

  it 'we can delete a food from the recipe' do
    visit recipe_path(Recipe.first)

    fill_in 'Quantity', with: '5'
    select 'Potato'
    click_button 'Add'

    click_button 'Delete'

    expect(page).to have_content 'No items found!'
  end
end
