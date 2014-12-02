require 'rails_helper'

describe 'Loading notifications', :type => :feature, js: true do
  before(:each) do
    @receiver = DummyObject.create! name: 'User'
    3.times { notification_with_mail(:always) } # page 2 with the last 3
    @last_notification_from_page = notification_with_mail(:always) # page 1

    2.times { notification_with_mail(:only) }  # are not in a page
    9.times { notification_with_mail(:never) } # page 1

    visit root_path
  end

  def notification_with_mail(occurrence)
    Notifly::Notification.create! receiver: @receiver, template: :default,
      read: false, mail: occurrence
  end

  scenario 'loading notifications in at the user click' do
    within("#notifly") do
      expect(page).to_not have_css('div.notifly-notification', visible: false)
    end

    wait_for_ajax { find('#notifly-icon').click }

    within('#notifly') do
      expect(page).to have_css('div.notifly-notification', count: 10, visible: false)
    end
  end

  scenario 'loading next page link' do
    href_with_page = notifly.notifications_path(current_notification_id: @last_notification_from_page.id)
    wait_for_ajax { find('#notifly-icon').click }
    within('#notifly-notifications-footer') do
      expect(page).to have_xpath("//a[@href=\"#{href_with_page}\"]")
    end

    click_ajax_link 'More'

    expect(page).to have_css('div.notifly-notification', count: 13, visible: false)
    within('#notifly-notifications-footer') do
      expect(page).to_not have_xpath("//a[@href=\"#{href_with_page}\"]")
    end
  end
end