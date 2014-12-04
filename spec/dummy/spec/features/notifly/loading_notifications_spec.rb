require 'rails_helper'

describe 'Loading notifications', :type => :feature, js: true do

  before(:each) { @receiver = DummyObject.create! name: 'User' }

  context 'when have notifications' do
    before(:each) do
      3.times { notification_with_mail(:always) } # page 2 with the last 3
      @last_notification_from_page = notification_with_mail(:always) # page 1

      2.times { notification_with_mail(:only) }  # are not in a page
      9.times { notification_with_mail(:never) } # page 1

      wait_for_ajax { visit root_path }
    end

    def notification_with_mail(occurrence)
      Notifly::Notification.create! receiver: @receiver, template: :default,
        read: false, mail: occurrence
    end

    scenario 'visiting page' do
      within("#notifly") do
        expect(page).to have_css('div.notifly-notification', count: 10, visible: false)
      end

      wait_for_ajax { find('#notifly-icon').click }

      within('#notifly') do
        expect(page).to have_css('div.notifly-notification', count: 10, visible: true)
      end
    end

    scenario 'loading next page link' do
      wait_for_ajax { find('#notifly-icon').click }

      within('#notifly-notifications-footer') do
        expect(page).to have_link('More')
      end

      click_ajax_link 'More'

      expect(page).to have_css('div.notifly-notification', count: 13, visible: true)
      within('#notifly-notifications-footer') do
        expect(page).to_not have_link('More')
      end
    end
  end

  context 'when none notifications' do
    scenario 'loading next page link' do
      wait_for_ajax { visit root_path }
      wait_for_ajax { find('#notifly-icon').click }

      within('#notifly-notifications-footer') do
        expect(page).to_not have_link('More')
      end
    end
  end
end