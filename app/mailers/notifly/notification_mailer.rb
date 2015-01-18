module Notifly
  class NotificationMailer < ActionMailer::Base
    default from: Notifly.mailer_sender

    def notifly(to: nil, notification_id: nil, template: nil)
      if defined? Delayed::Job or defined? Sidekiq::Worker
        delay.send_notification(to, notification_id, template)
      else
        send_notification(to, notification_id, template).deliver
      end
    end

    private
      def send_notification(to, notification_id, template)
        @notification = Notifly::Notification.find(notification_id)
        @template = template

        mail to: to, subject: t("notifly.mail_subject.#{@template}")
      end
  end
end
