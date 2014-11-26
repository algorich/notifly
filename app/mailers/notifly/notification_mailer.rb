module Notifly
  class NotificationMailer < ActionMailer::Base
    default from: Notifly.mailer_sender

    def notifly(to: nil, notification_id: nil, template: nil)
      @notification = Notifly::Notification.find(notification_id)
      @template = template

      mail(
        to: to,
        subject: t("notifly.mail_subject.#{@template}")
      ).deliver
    end
  end
end
