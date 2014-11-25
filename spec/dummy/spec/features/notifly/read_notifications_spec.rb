require 'rails_helper'

describe 'Read notification', :type => :feature, js: true do
  before do
    @receiver = DummyObject.create! name: 'User'
    @n_1 = Notifly::Notification.create! receiver: @receiver, read: false, mail: :never
    @n_2 = Notifly::Notification.create! receiver: @receiver, read: false, mail: :never
    @n_3 = Notifly::Notification.create! receiver: @receiver, read: false, mail: :never
    Notifly.per_page = 2
  end

  after(:each) do
    Notifly.per_page = 10
  end

  let(:open_notifly) do
    visit root_path
    wait_for_ajax { find('#notifly-icon').click }
  end

  context 'when read a specific notification' do
    scenario 'read a notification' do
      open_notifly

      notification_id = "#notifly-notification-#{@n_2.id}"
      expect(page).to have_selector ("#{notification_id}.notifly-notification-not-read")

      within(notification_id) do
        click_ajax_link 'read'
      end

      expect(page).to     have_selector (notification_id)
      expect(page).to_not have_selector ("#{notification_id}.notifly-notification-not-read")
    end

    scenario 'unread a notification' do
      notification = Notifly::Notification.create! receiver: @receiver, read: true,
        mail: :never
      notification_id = "#notifly-notification-#{notification.id}"
      open_notifly
      expect(page).to have_selector (notification_id)
      expect(page).to_not have_selector ("#{notification_id}.notifly-notification-not-read")

      within(notification_id) do
        click_ajax_link 'unread'
      end

      expect(page).to have_selector ("#{notification_id}.notifly-notification-not-read")
    end
  end

  scenario 'mark all read' do
    open_notifly

    expect(page).to     have_selector ("#notifly-notification-#{@n_3.id}.notifly-notification-not-read")
    expect(page).to     have_selector ("#notifly-notification-#{@n_2.id}.notifly-notification-not-read")
    expect(page).to_not have_selector ("#notifly-notification-#{@n_1.id}")

    within('#notifly') do
      click_ajax_link 'Mark as read'
      click_ajax_link 'More'
    end

    expect(page).to     have_selector ("#notifly-notification-#{@n_3.id}")
    expect(page).to     have_selector ("#notifly-notification-#{@n_2.id}")
    expect(page).to     have_selector ("#notifly-notification-#{@n_1.id}.notifly-notification-not-read")

    expect(page).to_not have_selector ("#notifly-notification-#{@n_3.id}.notifly-notification-not-read")
    expect(page).to_not have_selector ("#notifly-notification-#{@n_2.id}.notifly-notification-not-read")
  end
end