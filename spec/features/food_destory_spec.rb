require 'rails_helper'

describe "The foods page", type: :feature do
  before :each do
    user = User.create!(name: 'Ali', email: 'ali@example.com', password: '123456')
    Food.create!(user: User.first, name: 'Potato', measurement_unit: 'KG', price: 1)

    visit new_user_session_path
    fill_in 'Email', with: 'ali@example.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  it "shows one food before deleting" do
    visit '/foods'

    expect(page).to have_content 'Potato'
  end

  it "shows no food after deletig the only food" do
    visit '/foods'
    click_button 'Delete'

    expect(page).to have_content 'No food found'
  end
end