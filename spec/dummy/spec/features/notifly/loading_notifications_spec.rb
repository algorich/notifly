require 'rails_helper'

describe 'Notifly notifications', :type => :feature do
  before(:each) do
    @receiver = DummyObject.create! name: 'User'
    13.times { Notifly::Notification.create! receiver: @receiver, template: :default, read: false }
    Notifly::Notification.create! receiver: DummyObject.create!, template: :default
    Notifly::Notification.create! receiver: DummyObject.create!, template: :default
    visit root_path
  end

  scenario 'Loading notifications', js: true do
    within("#notifly") do
      expect(page).to_not have_css('div.notification')
    end

    find('#notifly').hover

    within('#notifly') do
      expect(page).to have_css('div.notifly-notification', count: 10)
    end
  end

  scenario 'Loading next page', js: true do
    params = { page: 2, receiver_id: @receiver.id, receiver_type: @receiver.class }
    href_with_params = notifly.notifications_path(params)
    find('#notifly').hover
    within('#notifly-notifications-footer') do
      expect(page).to have_link('more', href: href_with_params)
    end

    click_link 'more'

    within('#notifly-notifications-footer') do
      expect(page).to_not have_link('more', href: href_with_params)
    end
  end
end