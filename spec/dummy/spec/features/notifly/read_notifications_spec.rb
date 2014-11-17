require 'rails_helper'

describe 'Read notification', :type => :feature do
  before do
    @receiver = DummyObject.create! name: 'User'
    @notification_1 = Notifly::Notification.create! receiver: @receiver, template: :default, read: false
    @notification_2 = Notifly::Notification.create! receiver: @receiver, template: :default, read: false
    @notification_3 = Notifly::Notification.create! receiver: @receiver, template: :default, read: false

    visit root_path
    find('#notifly').hover
  end

  scenario 'specific notification', js: true do
    notification_id = "#notifly-notification-#{@notification_1.id}"
    expect(page).to have_selector ("#{notification_id}.notifly-notification-not-read")

    within(notification_id) do
      click_link 'read'
    end

    expect(page).to     have_selector (notification_id)
    expect(page).to_not have_selector ("#{notification_id}.notifly-notification-not-read")
  end
end