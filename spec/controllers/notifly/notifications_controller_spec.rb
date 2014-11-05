require 'rails_helper'

RSpec.describe Notifly::NotificationsController, :type => :controller do
  routes { Notifly::Engine.routes }
  before(:each) { request.accept = Mime::JS }

  describe 'GET count' do
    it 'should return the Notifications#count for a receiver' do
      receiver = DummyObject.create
      other_receiver = DummyObject.create

      3.times { Notifly::Notification.create! receiver: receiver, template: :default }
      2.times { Notifly::Notification.create! receiver: other_receiver, template: :default }

      get 'count', receiver_id: receiver.id, receiver_type: receiver.class

      expect(response).to have_http_status(:success)
      expect(assigns(:counter)).to eq(3)
    end
  end

end
