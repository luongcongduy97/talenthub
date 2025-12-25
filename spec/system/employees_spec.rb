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

    employee = Employee.find_by(name: 'John Doe')
    expect(page).to have_current_path(employee_path(employee))
    expect(page).to have_content('John Doe')
    expect(page).to have_content(company.name)

    visit employees_path
    expect(page).to have_content('John Doe')
  end

  it 'allows admin to search employees' do
    admin = create(:user, :admin)
    create(:employee, name: 'Alice Smith', position: 'Engineer')
    create(:employee, name: 'Bob Jones', position: 'Designer')

    visit new_user_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: 'password123'
    click_button 'Log in'

    visit employees_path
    fill_in 'query', with: 'Alice'
    click_button 'Search'

    expect(page).to have_content('Alice Smith')
    expect(page).not_to have_content('Bob Jones')
  end

  describe "Real-time notifications", js: true do
    before do
      driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
    end

    it 'notifies the linked user when admin updates their profile' do
      admin = create(:user, :admin)

      employee_user = create(:user, email: 'staff@example.com', password: 'password123')

      employee = create(:employee, name: 'John Staff', position: 'Junior Dev', user: employee_user)

      using_session("employee_browser") do
        login_user(employee_user)

        expect(page).to have_content('Talenthub')
        expect(page).to have_no_content('Your profile has been updated')
      end

      login_user(admin)

      visit edit_employee_path(employee)
      fill_in 'Position', with: 'Senior Developer'
      click_button 'Update Employee'

      using_session("employee_browser") do
        expect(page).to have_content('Your profile has been updated')
        expect(page).to have_content('Senior Developer')
      end
    end
  end
end
