require 'rails_helper'

RSpec.describe DummyObject, :type => :model do
  it { is_expected.to have_many(:posts) }

  describe 'Notifly' do
    let(:smart)              { DummyObject.create name: 'smart' }
    let(:dummy)              { DummyObject.create name: nil }
    let(:notifications)      { Notifly::Notification }

    it 'should return the method return' do
      expect(smart.buzz).to eql('buzz')
      expect(dummy.buzz).to eql('buzz')

      expect(smart.update(name: 'smart')).to be_truthy
      expect(dummy.update(name: 'dummy')).to be_truthy
    end

    context 'when using ActiveRecord methods' do
      describe 'class methods' do
        describe '.create' do
          it { expect { DummyObject.create name: 'dummy' }.
            to_not change(notifications.where(template: :create), :count) }
          it { expect { DummyObject.create name: 'smart' }.
            to change(notifications.where(template: :create), :count).from(0).to(1) }
        end
      end

      describe 'instance methods' do
        before(:each) do
          smart
          dummy
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
  end
end
