require 'rails_helper'

describe "The foods page", type: :feature do
  before :each do
    user = User.create!(name: 'Ali', email: 'ali@example.com', password: '123456')

    visit new_user_session_path
    fill_in 'Email', with: 'ali@example.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  it "shows no food before adding any" do
    visit '/foods'
    expect(page).to have_content 'No food found'
  end

  it "shows new food after adding it" do
    visit '/foods'
    click_link 'New'
    fill_in 'Name', with: 'Potato'
    fill_in 'Measurement unit', with: 'KG'
    fill_in 'Price', with: 1
    click_button 'Create'

    expect(page).to have_content 'Potato'
  end
end