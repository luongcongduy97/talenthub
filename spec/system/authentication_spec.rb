require 'rails_helper'

RSpec.describe 'Authentication', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'allows a user to register' do
    visit new_user_registration_path
    fill_in 'Email', with: 'systemuser@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'
    click_button 'Sign up'

    user = User.find_by(email: 'systemuser@example.com')
    expect(page).to have_current_path(user_path(user))
    expect(page).to have_content('User Details')
  end

  it 'allows a user to log in' do
    User.create!(email: 'systemlogin@example.com', password: 'password123', password_confirmation: 'password123')

    visit new_user_session_path
    fill_in 'Email', with: 'systemlogin@example.com'
    fill_in 'Password', with: 'password123'
    click_button 'Log in'

    user = User.find_by(email: 'systemlogin@example.com')
    expect(page).to have_current_path(user_path(user))
    expect(page).to have_content('User Details')
  end
end
