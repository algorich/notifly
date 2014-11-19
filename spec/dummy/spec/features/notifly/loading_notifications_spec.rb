require 'rails_helper'

describe 'Loading notifications', :type => :feature, js: true do
  before(:each) do
    @receiver = DummyObject.create! name: 'User'
    13.times { Notifly::Notification.create! receiver: @receiver, template: :default, read: false }
    Notifly::Notification.create! receiver: DummyObject.create!, template: :default
    Notifly::Notification.create! receiver: DummyObject.create!, template: :default
    visit root_path
  end

  scenario 'loading notifications in background when user hover notifly' do
    within("#notifly") do
      expect(page).to_not have_css('div.notifly-notification', visible: false)
    end

    wait_for_ajax { find('#notifly').hover }

    within('#notifly') do
      expect(page).to have_css('div.notifly-notification', count: 10, visible: false)
    end
  end

  scenario 'loading next page link' do
    href_with_page = notifly.notifications_path(page: 2)
    wait_for_ajax { find('#notifly').hover }

    within('#notifly-notifications-footer', visible: false) do
      expect(page).to have_xpath("//a[@href=\"#{href_with_page}\"]", visible: false)
    end

    wait_for_ajax { find('#notifly-icon').click }
    within('#notifly-notifications-footer') do
      expect(page).to have_xpath("//a[@href=\"#{href_with_page}\"]")
    end


    click_ajax_link 'More'
    within('#notifly-notifications-footer') do
      expect(page).to_not have_xpath("//a[@href=\"#{href_with_page}\"]")
    end
  end
end