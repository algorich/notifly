require 'rails_helper'

describe 'Notifly counter', :type => :feature do
  let(:user) { DummyObject.create! }

  scenario "Loading notification's counter" do
    Notifly::Notification.create! receiver: user, template: :default
    Notifly::Notification.create! receiver: user, template: :default
    Notifly::Notification.create! receiver: DummyObject.create!, template: :default
    Notifly::Notification.create! receiver: DummyObject.create!, template: :default

    visit root_path

    within("#notifly-counter") do
      expect(page).to have_content '2'
    end
  end
end