require 'rails_helper'

RSpec.describe 'Companies', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'allows admin to create and view a company' do
    admin = create(:user, :admin)

    visit new_user_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: 'password123'
    click_button 'Log in'

    visit new_company_path
    fill_in 'Name', with: 'Test Corp'
    fill_in 'Industry', with: 'Tech'
    click_button 'Create Company'

    company = Company.last
    expect(page).to have_current_path(company_path(company))
    expect(page).to have_content('Test Corp')

    visit companies_path
    expect(page).to have_content('Test Corp')
  end
end
