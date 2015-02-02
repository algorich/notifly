require 'rails_helper'

RSpec.describe Post, :type => :model do
  it { is_expected.to belong_to(:dummy_object) }

  describe 'Notifly' do
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
        expect(notification.template).to eql 'publish'
      end

      describe 'Notification fallback (data)' do
        it 'should use Notifly::Notification#data for missing informations' do
          post_attributes = post.attributes
          expect { post.destroy }.to change(Notifly::Notification, :count).from(0).to(1)

          expect(notification.receiver).to eql dummy
          expect(notification.template).to eql 'destroy'
          expect(notification.reload.data).to eql post_attributes
        end

        context 'when run notifly by order' do
          context 'when post title starts with nil' do
            it 'should send two notifications' do
              post_1 = Post.create dummy_object: dummy, published: true, title: 'TitleBar'

              expect { post_1.change_title }.to change(Notifly::Notification, :count).
                by(2)

              expect(Notifly::Notification.first.data['title_before_create']).to eql 'TitleBar'
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

    describe '#notifly_notifications' do
      it 'should show its notifications' do
        dummy_notification = Notifly::Notification.create! receiver: dummy,
          sender: post, mail: :never
        post_notifications = (1..3).map do
          Notifly::Notification.create! receiver: post, sender: dummy, mail: :never
        end

        expect(post.notifly_notifications).to     include(*post_notifications)
        expect(post.notifly_notifications).to_not include(dummy_notification)
      end

      it 'should query its notifications' do
        dummy_2 = DummyObject.create
        notification_1 = Notifly::Notification.create! receiver: post,
          sender: dummy, template: 'destroy', mail: :never
        notification_2 = Notifly::Notification.create! receiver: post,
          sender: dummy, target: dummy_2, mail: :never
        notification_3 = Notifly::Notification.create! receiver: post,
          sender: dummy, target: dummy_2, mail: :never

        destroy_notifications = post.notifly_notifications.where(template: 'destroy')
        dummy_2_notifications = post.notifly_notifications.where(target: dummy_2)

        expect(destroy_notifications).to     include(notification_1)
        expect(destroy_notifications).to_not include(notification_2, notification_3)
        expect(dummy_2_notifications).to     include(notification_2, notification_3)
        expect(dummy_2_notifications).to_not include(notification_1)
      end
    end
  end
end
