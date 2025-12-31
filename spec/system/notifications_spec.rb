require 'rails_helper'

RSpec.describe 'Notifications System', type: :system do
  let!(:user) { create(:user) }

  let!(:notifications) {
    create_list(:notification, 3, user: user, read_at: nil, message: "New Message")
  }

  before do
    login_user(user)
  end

  it 'allows user to mark ALL as read' do
    expect(page).to have_css('[data-notifications-target="badge"]', visible: true)

    find('button', text: 'View notifications').click

    expect(page).to have_css('[data-notifications-target="dropdown"]', visible: true)

    expect(page).to have_css("a.bg-blue-50", count: 3)

    click_on "Mark all as read"

    expect(page).to have_no_css("a.bg-blue-50")
    expect(page).to have_css("a.opacity-50", count: 3)
    expect(page).to have_no_css('[data-notifications-target="badge"]', visible: true)

    sleep 0.5
    expect(user.notifications.unread.count).to eq(0)
  end

  it 'allows user to mark SINGLE notification as read' do
    find('button', text: 'View notifications').click
    expect(page).to have_css('[data-notifications-target="dropdown"]', visible: true)

    first_notification = notifications.first
    target_selector = "a[href='#{first_notification.url}']"

    expect(page).to have_css("#{target_selector}.bg-blue-50")

    find(target_selector).click

    expect(page).to have_css("#{target_selector}.opacity-50")

    expect(page).to have_no_css("#{target_selector}.bg-blue-50")
    expect(page).to have_css("a.bg-blue-50", count: 2)

    sleep 0.5
    expect(first_notification.reload.read_at).to be_present
    expect(user.notifications.unread.count).to eq(2)
  end
end
