require 'rails_helper'

RSpec.describe Notifly::NotificationsController, :type => :controller do
  routes { Notifly::Engine.routes }
  before(:each) { request.accept = Mime::JS }

  describe 'GET count' do
    it 'should return the Notifications#count for a receiver' do
      receiver = DummyObject.create
      other_receiver = DummyObject.create

      Notifly::Notification.create! receiver: receiver, template: :default, read: false
      Notifly::Notification.create! receiver: receiver, template: :default, read: false
      Notifly::Notification.create! receiver: receiver, template: :default, read: false
      Notifly::Notification.create! receiver: receiver, template: :default, read: true

      2.times { Notifly::Notification.create! receiver: other_receiver, template: :default }

      get :count, receiver_id: receiver.id, receiver_type: receiver.class

      expect(response).to have_http_status(:success)
      expect(assigns(:counter)).to eq(3)
    end
  end

  describe 'GET index' do
    it 'should return notifications paginated' do
      receiver = DummyObject.create
      other_receiver = DummyObject.create

      15.times { Notifly::Notification.create! receiver: receiver, template: :default,
        read: [true, false].sample }
      2.times { Notifly::Notification.create! receiver: other_receiver, template: :default }

      get :index, receiver_id: receiver.id, receiver_type: receiver.class

      expect(response).to have_http_status(:success)
      expect(assigns(:notifications).count).to eq(10)
    end
  end

end
