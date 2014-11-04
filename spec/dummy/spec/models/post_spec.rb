require 'rails_helper'

RSpec.describe Post, :type => :model do
  it { is_expected.to belong_to(:dummy_object) }

  describe 'Notifly usage' do
    let(:dummy)        { DummyObject.create! }
    let(:post)         { Post.create! dummy_object: dummy, published: false }
    let(:publish)      { post.update(published: true) }
    let(:notification) { Notifly::Notification.take }

    it 'should create a notification when is published' do
      expect(Notifly::Notification.count).to eql 0

      expect { publish }.to change(Notifly::Notification, :count).from(0).to(1)
      expect(notification.receiver).to eql dummy
      expect(notification.template).to eql 'default'
    end
  end
end
