require "rails_helper"

module Notifly
  RSpec.describe Notifly::Models::Flyable do
    let!(:dummy) { DummyObject.create name: 'Dummy', email: 'dummy@test.com' }

    before(:each) do
      allow(Notifly::Notification).to receive(:create).
        and_raise(ActiveRecord::RecordInvalid, Notifly::Notification.new)
        expect(Rails.logger).to receive(:error)
    end

    after(:each) { Rails.env = 'test' }

    it 'should not raise an error if something wrong happened in production' do
      Rails.env = 'production'

      expect { dummy.be_smart }.to_not raise_error
    end

    it 'should raise an error if something wrong happened' do
      expect { dummy.be_smart }.to raise_error
    end
  end
end
