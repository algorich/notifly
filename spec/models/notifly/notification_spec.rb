require 'rails_helper'

module Notifly
  RSpec.describe Notification, :type => :model do
    it { is_expected.to validate_presence_of(:receiver) }
    it { is_expected.to validate_presence_of(:mail) }

    describe '#data' do
      it 'should save and repond with a hash' do
        hash = { 'post' => Post.create!.attributes }

        notification = Notifly::Notification.create! receiver: DummyObject.create,
          template: :foo, data: hash, mail: :never

        expect(notification.reload.data).to eql hash
      end
    end

    describe '.page' do
      let(:page_1) { [ ] }
      let(:page_2) { [ ] }
      let(:page_3) { [ ] }
      let(:last_notification_from_page_2) { simple_notification }
      let(:last_notification_from_page_1) { simple_notification }

      def simple_notification
        Notifly::Notification.create! receiver: DummyObject.create!, mail: :never
      end

      before(:each) do
        Notifly.per_page = 4

        3.times { page_3 << simple_notification }
        page_2 << last_notification_from_page_2
        3.times { page_2 << simple_notification }
        page_1 << last_notification_from_page_1
        3.times { page_1 << simple_notification }
      end

      it { expect(Notifly::Notification.page).to match_array page_1 }
      it { expect(Notifly::Notification.page from: last_notification_from_page_1.id).
        to match_array page_2 }
      it { expect(Notifly::Notification.page from: last_notification_from_page_2).
        to match_array page_3 }
    end
  end
end
