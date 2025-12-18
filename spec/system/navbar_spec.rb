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
      # 1. Resize và IN RA kích thước thật để kiểm tra
      page.driver.browser.manage.window.resize_to(375, 667)

      # In kích thước cửa sổ ra màn hình console của CI
      window_size = page.driver.browser.manage.window.size
      puts "🛑 DEBUG: Kích thước màn hình hiện tại: #{window_size.width}x#{window_size.height}"

      # 2. Chụp ảnh TRƯỚC khi click (để xem nút bấm có hiện không)
      page.save_screenshot('debug_before_click.png')

      # 3. Thử Click
      puts "🛑 DEBUG: Đang thực hiện click..."
      button = find('button[data-action="click->menu#toggle"]')
      button.click

      # 4. Tạm dừng 1 giây (để chờ JS chạy - phòng trường hợp máy CI quá lag)
      sleep 1

      # 5. In ra class hiện tại của cái menu
      menu = find('div[data-menu-target="menu"]', visible: :all)
      puts "🛑 DEBUG: Class của menu sau khi click: '#{menu[:class]}'"

      # 6. Chụp ảnh SAU khi click (để xem menu có bung ra không)
      page.save_screenshot('debug_after_click.png')

      # Check như bình thường
      expect(page).to have_selector('div[data-menu-target="menu"]', visible: true)
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
