require 'rails_helper'

RSpec.describe DummyObject, :type => :model do
  it { is_expected.to have_many(:posts) }

  describe 'Notifly' do
    it 'should return the method return' do
      smart = DummyObject.create name: 'smart'
      dummy = DummyObject.create name: nil

      expect(smart.buzz).to eql('buzz')
      expect(dummy.buzz).to eql('buzz')

      expect(smart.update(name: 'smart')).to be_truthy
      expect(dummy.update(name: 'dummy')).to be_truthy
    end

    context 'when using ActiveRecord methods' do
      let(:notifications) { Notifly::Notification.not_only_mail }

      describe 'class methods' do
        describe '.create' do
          it { expect { DummyObject.create name: 'dummy' }.
            to_not change(notifications.where(template: :create), :count) }
          it { expect { DummyObject.create name: 'smart' }.
            to change(notifications.where(template: :create), :count).from(0).to(1) }
        end
      end

      describe 'instance methods' do
        let!(:smart) { DummyObject.create name: 'smart', email: 'smart@mail.com' }
        let!(:dummy) { DummyObject.create name: nil, email: 'dummy@mail.com' }

        before(:each) do
          notifications.delete_all
        end

        describe '#save' do
          it { expect { smart.save! }.to change(notifications.
            where(template: :save), :count).from(0).to(1) }
          it { expect { dummy.save! }.to_not change(notifications.
            where(template: :save), :count) }
        end

        describe '#update' do
          it { expect { dummy.update!(name: 'smart') }.to change(notifications.
            where(template: :update), :count).from(0).to(1) }
          it { expect { smart.update!(name: 'dummy') }.to_not change(notifications.
            where(template: :update), :count) }
        end

        describe '#destroy' do
          it { expect { smart.destroy! }.to change(notifications, :count).
            from(0).to(1) }
          it { expect { dummy.destroy! }.to_not change(notifications, :count) }
        end
      end
    end

    context 'when notifly send email' do
      let!(:smart) { DummyObject.create name: 'smart', email: 'smart@mail.com' }
      let!(:dummy) { DummyObject.create name: nil, email: 'dummy@mail.com' }
      let(:notifications) { Notifly::Notification }

      before(:each) do
        notifications.delete_all
        emails_sent.clear
      end

      it 'should create a visible notification with email' do
        expect { smart.destroy! }.to change(emails_sent, :size).from(0).to(1)

        expect(notifications.count).to eql(1)
        expect(smart.notifly_notifications.not_only_mail).to include notifications.take
      end

      it 'should create an invisible notification with email' do
        expect { dummy.be_smart }.to change(emails_sent, :size).from(0).to(1)

        expect(notifications.count).to eql(1)
        expect(dummy.notifly_notifications.not_only_mail).to_not include notifications.take
      end
    end

    context 'when using kind' do
      let!(:dummy) { DummyObject.create name: nil, email: 'dummy@mail.com' }
      let(:notifications) { Notifly::Notification }

      before(:each) do
        notifications.delete_all
        emails_sent.clear
      end

      describe '#notifly_notifications' do
        it 'should show notifications by kind' do
          expect { dummy.test_kind }.to change { notifications.count }.by(2)

          expect(dummy.notifly_notifications.count).to eql 2

          expect(dummy.notifly_notifications(:message).count).to eql 1
          expect(dummy.notifly_notifications(:message)).
            to match_array notifications.where(receiver: dummy, kind: :message)

          expect(dummy.notifly_notifications(:feed).count).to eql 1
          expect(dummy.notifly_notifications(:feed)).
            to match_array notifications.where(receiver: dummy, kind: :feed)
        end
      end
    end

    context 'when using "then"' do
      let!(:dummy) { DummyObject.create name: nil, email: 'dummy@mail.com' }
      let(:notifications) { Notifly::Notification }

      before(:each) { notifications.delete_all }

      it 'should run the code' do
        expect(dummy.name).to eql nil

        expect { dummy.test_then }.to change { notifications.count }.by(1)
        expect(dummy.reload.name).to eql 'name_after_then'
      end

      it 'should run the code using the created notification' do
        expect(dummy.name).to eql nil

        expect { dummy.test_then_using_notification }.to change { notifications.count }.by(1)
        expect(dummy.reload.name).to eql 'blastoise'
      end
    end
  end
end
