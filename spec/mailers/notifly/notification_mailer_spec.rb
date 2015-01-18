require "rails_helper"

module Notifly
  RSpec.describe NotificationMailer, :type => :mailer do
    let(:mail) { NotificationMailer.notifly(to: dummy.email, template: notification.template,
      notification_id: notification.id) }
    let(:notification) { Notifly::Notification.create! receiver: dummy,
      mail: :always }
    let(:dummy) { DummyObject.create name: 'Dummy', email: 'dummy@test.com' }

    it 'should guarantee that the receiver is correct' do
      expect(mail.to).to eq([dummy.email])
    end

    it 'should guarantee that the sender is correct' do
      expect(mail.from).to eq(['change-me-at-config-initializers-notifly@exemple.com'])
    end

    it 'should guarantee that the subject is correct' do
      expect(mail.subject).to include('You have a new notification')
    end

    it 'should guarantee that all information appears on the email body' do
      expect(mail.body).to include('Default notification mail')
    end

    context 'when using other templates' do
      let(:notification) { Notifly::Notification.create! receiver: dummy,
        mail: :only, template: :hello }

      it 'should guarantee that the subject is correct' do
        expect(mail.subject).to include('Hello!')
      end

      it 'should guarantee that all information appears on the email body' do
        expect(mail.body).to include('Hello mail')
      end
    end
  end
end
