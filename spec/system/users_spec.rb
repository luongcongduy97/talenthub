require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'allows admin to view user index' do
    admin = create(:user, :admin)
    user = create(:user)

    visit new_user_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: 'password123'
    click_button 'Log in'

    visit users_path
    expect(page).to have_content(user.email)
  end

  it 'shows profile for a signed in user' do
    user = create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password123'
    click_button 'Log in'

    expect(page).to have_current_path(user_path(user))
    expect(page).to have_content('User Details')
    expect(page).to have_content(user.email)
  end
end
