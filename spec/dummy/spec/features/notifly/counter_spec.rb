require 'rails_helper'

describe 'Notifly counter', :type => :feature, js: true do
  let(:notification) { Notifly::Notification }
  let(:receiver)     { DummyObject.create! name: 'User' }

  before(:each) do
    notification.create! receiver: receiver, seen: true, read: false, mail: :never
    notification.create! receiver: receiver, seen: false, read: false, mail: :never
    notification.create! receiver: receiver, seen: false, read: false, mail: :always
    notification.create! receiver: receiver, seen: false, read: false, mail: :always
    notification.create! receiver: DummyObject.create!, seen: false, read: false,
      mail: :never
    notification.create! receiver: DummyObject.create!, seen: false, read: false,
      mail: :never
    Notifly.per_page = 2
  end

  after(:each) do
    Notifly.per_page = 10
  end

  scenario 'seeing notifications' do
    wait_for_ajax { visit root_path }
    within("#notifly-counter") do
      expect(page).to have_content '3'
    end

    wait_for_ajax { find('#notifly-icon').click }

    within("#notifly-counter") do
      expect(page).to have_content '1'
    end

    click_ajax_link 'More'

    within("#notifly-counter", visible: false) do
      expect(page).to have_content '0'
    end
  end

  context 'when notification is mail only' do
    scenario 'seeing only notifications without mail only' do
      notification.create! receiver: receiver, seen: false, read: false, mail: :only
      wait_for_ajax { visit root_path }

      within("#notifly-counter") do
        expect(page).to_not have_content '4'
        expect(page).to     have_content '3'
      end
    end
  end
end