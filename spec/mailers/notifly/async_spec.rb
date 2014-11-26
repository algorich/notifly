require "rails_helper"

module Notifly
  RSpec.describe 'Async Mail' do
    let(:dummy) { DummyObject.create name: 'Dummy', email: 'dummy@test.com' }

    it 'should not call #delay with app does not use delayed_job or sidekiq' do
      expect_any_instance_of(NotificationMailer).not_to receive(:delay)
      dummy.be_smart
    end

    it 'should call #delay with app use delayed_job' do
      stub_const 'Delayed::Job', Module.new

      expect_any_instance_of(NotificationMailer).to receive_message_chain('delay.send_notification')
      dummy.be_smart
    end

    it 'should call #delay with app use delayed_job' do
      stub_const 'Sidekiq::Worker', Module.new

      expect_any_instance_of(NotificationMailer).to receive_message_chain('delay.send_notification')
      dummy.be_smart
    end
  end
end
