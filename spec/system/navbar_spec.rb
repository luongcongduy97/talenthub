require 'rails_helper'

RSpec.describe 'Navbar', type: :system do
  let(:user) { User.create!(email: 'user@example.com', password: 'password123', password_confirmation: 'password123') }

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
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end

    context 'on desktop' do
      it 'shows the navigation links' do
        expect(page).to have_link('Companies', href: companies_path)
        expect(page).to have_link('Employees', href: employees_path)
        expect(page).to have_button('Logout')
      end
    end

    context 'on mobile', js: true do
      before do
        driven_by :selenium, using: :headless_chrome, screen_size: [ 375, 667 ]
      end

      it 'toggles the menu visibility when clicked' do
        expect(page).to have_selector('div[data-menu-target="menu"]', visible: false)

        find('button[data-action="click->menu#toggle"]').click
        expect(page).to have_selector('div[data-menu-target="menu"]', visible: true)

        find('button[data-action="click->menu#toggle"]').click
        expect(page).to have_selector('div[data-menu-target="menu"]', visible: false)
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
end
