require 'rails_helper'

RSpec.describe 'Navbar', type: :system do
  context 'when not signed in' do
    it 'shows brand link but hides navigation links' do
      visit new_user_session_path

      expect(page).to have_link('Talenthub', href: root_path)
      expect(page).not_to have_link('Companies')
      expect(page).not_to have_link('Employees')
      expect(page).not_to have_button('Logout')
    end
  end

  context 'when signed in' do
    before do
      @user = User.create!(email: 'navuser@example.com', password: 'password123', password_confirmation: 'password123')
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'password123'
      click_button 'Log in'
    end

    it 'shows the navigation links' do
      expect(page).to have_link('Companies', href: companies_path)
      expect(page).to have_link('Employees', href: employees_path)
      expect(page).to have_button('Logout')
    end
  end

  context 'mobile menu', js: true do
    before do
      driven_by(:selenium, using: :headless_chrome)
      page.driver.browser.manage.window.resize_to(375, 800)

      @user = User.create!(email: 'menutest@example.com', password: 'password123', password_confirmation: 'password123')
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'password123'
      click_button 'Log in'
    end

    it 'toggles when the button is clicked' do
      page.driver.browser.manage.window.resize_to(375, 667)
      expect(page).to have_css('div[data-menu-target="menu"].hidden', visible: :all)

      find('button[data-action="click->menu#toggle"]').click
      expect(page).to have_no_css('div[data-menu-target="menu"].hidden', visible: :all)

      find('button[data-action="click->menu#toggle"]').click
      expect(page).to have_css('div[data-menu-target="menu"].hidden', visible: :all)
    end

    it 'contains navigation links inside the menu' do
      find('button[data-action="click->menu#toggle"]').click
      within('div[data-menu-target="menu"]') do
        expect(page).to have_link('Companies', href: companies_path)
        expect(page).to have_link('Employees', href: employees_path)
        expect(page).to have_button('Logout')
      end
    end
  end
end
