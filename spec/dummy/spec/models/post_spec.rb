require 'rails_helper'

RSpec.describe Post, :type => :model do
  it { is_expected.to belong_to(:dummy_object) }

  describe 'Notifly usage' do
    let(:dummy)        { DummyObject.create! }
    let(:post)         { Post.create! dummy_object: dummy, published: false }
    let(:notification) { Notifly::Notification.take }

    describe 'initialization' do
      it { expect(Post).to respond_to :notifly }
    end

    describe 'usage' do
      it 'should create a notification when is published' do
        expect(Notifly::Notification.count).to eql 0

        expect { post.publish! }.to change(Notifly::Notification, :count).from(0).to(1)
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

      context 'when run notifly by order' do
        context 'when post title starts with nil' do
          it 'should send two notifications' do
            expect { post.change_title }.to change(Notifly::Notification, :count).
              from(0).to(2)

            expect(Notifly::Notification.first.data['title']).to be_nil
            expect(Notifly::Notification.last.data['title']).to eql 'NewTitle'
          end
        end

        context 'when post title starts with TitleFoo' do
          it 'should send two notifications' do
            expect_any_instance_of(Post).to receive(:change_title) { nil }
            post = Post.create! dummy_object: dummy, title: 'TitleFoo'

            expect { post.change_title }.to_not change(Notifly::Notification, :count)
          end
        end
      end
    end
  end
end
