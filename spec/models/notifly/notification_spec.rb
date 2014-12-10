require 'rails_helper'

module Notifly
  RSpec.describe Notification, :type => :model do
    describe 'validations' do
      it { is_expected.to validate_presence_of(:receiver) }
      it 'should validates presence of template' do
        is_expected.to_not validate_presence_of(:template)

        allow_any_instance_of(Notification).to receive(:set_template) { nil }
        is_expected.to validate_presence_of(:template)
      end
      it 'should validates presence of mail' do
        is_expected.to_not validate_presence_of(:mail)

        allow_any_instance_of(Notification).to receive(:set_mail) { nil }
        is_expected.to validate_presence_of(:mail)
      end
    end

    describe '#data' do
      it 'should save and repond with a hash' do
        hash = { 'post' => Post.create!.attributes }

        notification = Notifly::Notification.create! receiver: DummyObject.create,
          template: :foo, data: hash, mail: :never

        expect(notification.reload.data).to eql hash
      end
    end

    describe 'scopes' do
      def simple_notification
        Notifly::Notification.create! receiver: DummyObject.create!, mail: :never
      end

      before(:each) { Notifly.per_page = 4 }

      describe '.newer' do
        it 'should return first page if do not receive params' do
          page_1 = []
          first_notification_from_page_2 = simple_notification
          3.times { page_1 << simple_notification }
          page_1 << first_notification_from_page_1 = simple_notification

          expect(Notifly::Notification.newer).to match_array page_1
        end

        it 'should return newer notifications than a specific notification' do
          new_notification_1 = simple_notification
          new_notification_2 = simple_notification
          new_notification_3 = simple_notification
          new_notification_4 = simple_notification

          expect(Notifly::Notification.newer than: new_notification_2.id).
            to match_array [new_notification_3, new_notification_4]
        end
      end

      describe '.between' do
        it 'should return notifications between specific notifications' do
          notifications = []
          notification_1 = simple_notification
          notification_2 = simple_notification
          notification_3 = simple_notification
          notification_4 = simple_notification
          notification_5 = simple_notification
          notification_6 = simple_notification

          expect(Notifly::Notification.between notification_2, notification_5).
            to match_array [notification_2, notification_3, notification_4, notification_5]
        end
      end

      describe '.older' do
        let(:page_1) { [ ] }
        let(:page_2) { [ ] }
        let(:page_3) { [ ] }

        before(:each) do
          page_3 << @last_notification_from_page_3 = simple_notification
          3.times { page_3 << simple_notification }
          page_2 << @last_notification_from_page_2 = simple_notification
          3.times { page_2 << simple_notification }
          page_1 << @last_notification_from_page_1 = simple_notification
          3.times { page_1 << simple_notification }
        end

        it { expect(Notifly::Notification.older than: @last_notification_from_page_1.id).
          to match_array page_2 }
        it { expect(Notifly::Notification.older than: @last_notification_from_page_2.id).
          to match_array page_3 }
        it { expect(Notifly::Notification.older than: @last_notification_from_page_3.id).
          to match_array [] }
      end
    end
  end
end
