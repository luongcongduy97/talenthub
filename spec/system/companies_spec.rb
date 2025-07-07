require 'rails_helper'

RSpec.describe 'Companies', type: :system do
  it 'allows admin to create a company' do
    admin = User.create!(email: 'adminui@example.com', password: 'password123', password_confirmation: 'password123')
    admin.add_role(:admin)

    visit new_user_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: 'password123'
    click_button 'Log in'

    visit new_company_path
    fill_in 'Name', with: 'UI Co'
    fill_in 'Industry', with: 'Tech'
    click_button 'Create Company'

    expect(page).to have_content('UI Co')
  end
end
