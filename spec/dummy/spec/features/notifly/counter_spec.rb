require 'rails_helper'

describe 'Notifly counter', :type => :feature do
  scenario "Loading notification's counter", js: true do
    receiver = DummyObject.create! name: 'User'
    Notifly::Notification.create! receiver: receiver, template: :default
    Notifly::Notification.create! receiver: receiver, template: :default
    Notifly::Notification.create! receiver: DummyObject.create!, template: :default
    Notifly::Notification.create! receiver: DummyObject.create!, template: :default

    visit root_path

    within("#notifly-counter") do
      expect(page).to have_content '2'
    end
  end
end