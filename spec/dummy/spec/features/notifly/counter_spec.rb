require 'rails_helper'

describe 'Notifly counter', :type => :feature, js: true do
  before(:each) do
    receiver = DummyObject.create! name: 'User'
    Notifly::Notification.create! receiver: receiver, seen: true, read: false
    Notifly::Notification.create! receiver: receiver, seen: false, read: false
    Notifly::Notification.create! receiver: receiver, seen: false, read: false
    Notifly::Notification.create! receiver: receiver, seen: false, read: false
    Notifly::Notification.create! receiver: DummyObject.create!, seen: false, read: false
    Notifly::Notification.create! receiver: DummyObject.create!, seen: false, read: false
    Notifly.per_page = 2

    visit root_path
  end

  after(:each) do
    Notifly.per_page = 10
  end

  scenario 'loading notifications but not seen them' do
    within("#notifly-counter") do
      expect(page).to have_content '3'
    end

    wait_for_ajax { find('#notifly').hover }
    visit root_path

    within("#notifly-counter") do
      expect(page).to have_content '3'
    end
  end

  scenario 'seeing notifications' do
    wait_for_ajax { find('#notifly').hover }
    wait_for_ajax { find('#notifly-icon').click }

    within("#notifly-counter") do
      expect(page).to have_content '1'
    end

    click_ajax_link 'More'

    within("#notifly-counter") do
      expect(page).to_not have_content '1'
    end
  end
end