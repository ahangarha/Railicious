require 'rails_helper'

RSpec.describe 'Sign up Page', type: :system do
  before do
    driven_by(:rack_test)
    visit 'users/sign_up'
  end

  it 'I can see the email and password inputs and the "Submit" button.' do
    expect(page).to have_selector('input[type="text"]')
    expect(page).to have_selector('input[type="email"]')
    expect(page).to have_selector('input[type="password"]')
    expect(page).to have_selector('input[type="submit"]')
  end

  it 'When I click the submit button after filling in the username and
  the password with correct data, I am redirected to the root page.' do
    within('#new_user') do
      fill_in 'Name', with: 'conman'
      fill_in 'Email', with: 'conman@gmail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
    end
    find_button('Sign up').click
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end