module AuthenticationHelper
  def login_user(user, password = "password123")
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: password

    within('#new_user') do
      click_button "Log in"
    end

    expect(page).to have_content('Talenthub')
  end
end
