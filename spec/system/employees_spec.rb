require 'rails_helper'

RSpec.describe 'Employees', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'allows admin to create and view an employee' do
    admin = create(:user, :admin)
    company = create(:company)
    user = create(:user)

    visit new_user_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: 'password123'
    click_button 'Log in'

    visit new_employee_path
    fill_in 'Name', with: 'John Doe'
    fill_in 'Position', with: 'Engineer'
    select company.name, from: 'Company'
    select user.email, from: 'User'
    click_button 'Create Employee'

    employee = Employee.last
    expect(page).to have_current_path(employee_path(employee))
    expect(page).to have_content('John Doe')
    expect(page).to have_content(company.name)

    visit employees_path
    expect(page).to have_content('John Doe')
  end
end
