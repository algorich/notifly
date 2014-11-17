require 'rails_helper'

describe 'Notifly counter', :type => :feature do
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

  scenario "Loading notification's counter", js: true do
    within("#notifly-counter") do
      expect(page).to have_content '3'
    end
  end

  scenario 'when seeing notifications', js: true do
    find('#notifly').hover
    sleep(1)
    find('#notifly').click

    within("#notifly-counter") do
      expect(page).to have_content '1'
    end
  end
end