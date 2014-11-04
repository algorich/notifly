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
      expect(notification.target).to eql post
      expect(notification.template).to eql 'default'
    end

    describe 'Notification fallback (data)' do
      it 'should use Notifly::Notification#data for missing informations' do
        post_attributes = post.attributes
        expect { post.destroy }.to change(Notifly::Notification, :count).from(0).to(1)

        expect(notification.receiver).to eql dummy
        expect(notification.template).to eql 'destroy'
        expect(notification.reload.data).to eql post_attributes
      end
    end
  end
end
