module Notifly
  class NotificationMailer < ActionMailer::Base
    default from: Notifly.mailer_sender

    def notifly(to: nil, notification: nil)
      @notification = notification

      mail(
        to: to,
        subject: t("notifly.mail_subject.#{notification.template}")
      ).deliver
    end
  end
end
