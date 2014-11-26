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
  end
end
