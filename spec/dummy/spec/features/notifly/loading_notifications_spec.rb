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
    href_with_page = notifly.notifications_path(page: 2)
    find('#notifly').hover
    within('#notifly-notifications-footer') do
      expect(page).to have_link('more', href: href_with_page)
    end

    click_link 'more'

    within('#notifly-notifications-footer') do
      expect(page).to_not have_link('more', href: href_with_page)
    end
  end
end