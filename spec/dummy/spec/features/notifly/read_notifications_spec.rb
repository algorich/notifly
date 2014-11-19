require 'rails_helper'

describe 'Read notification', :type => :feature, js: true do
  before do
    @receiver = DummyObject.create! name: 'User'
    @n_1 = Notifly::Notification.create! receiver: @receiver, template: :default, read: false
    @n_2 = Notifly::Notification.create! receiver: @receiver, template: :default, read: false
    @n_3 = Notifly::Notification.create! receiver: @receiver, template: :default, read: false
    Notifly.per_page = 2

    visit root_path
    sleep(1)
    find('#notifly').hover
    sleep(1)
    find('#notifly-icon').click
  end

  after(:each) do
    Notifly.per_page = 10
  end

  scenario 'specific notification' do
    notification_id = "#notifly-notification-#{@n_2.id}"
    expect(page).to have_selector ("#{notification_id}.notifly-notification-not-read")

    within(notification_id) do
      click_link 'read'
    end

    expect(page).to     have_selector (notification_id)
    expect(page).to_not have_selector ("#{notification_id}.notifly-notification-not-read")
  end

  scenario 'mark all read' do
    expect(page).to     have_selector ("#notifly-notification-#{@n_3.id}.notifly-notification-not-read")
    expect(page).to     have_selector ("#notifly-notification-#{@n_2.id}.notifly-notification-not-read")
    expect(page).to_not have_selector ("#notifly-notification-#{@n_1.id}")

    within('#notifly') do
      click_link 'Mark as read'
      click_link 'More'
    end

    expect(page).to     have_selector ("#notifly-notification-#{@n_3.id}")
    expect(page).to     have_selector ("#notifly-notification-#{@n_2.id}")
    expect(page).to     have_selector ("#notifly-notification-#{@n_1.id}.notifly-notification-not-read")

    expect(page).to_not have_selector ("#notifly-notification-#{@n_3.id}.notifly-notification-not-read")
    expect(page).to_not have_selector ("#notifly-notification-#{@n_2.id}.notifly-notification-not-read")
  end
end