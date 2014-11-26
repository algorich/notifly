module Notifly
  class NotificationMailer < ActionMailer::Base
    default from: Notifly.mailer_sender

    def notifly(to: nil, notification: nil, fly: Notifly::Models::Options::Fly.new)
      @notification = notification
      @template = fly.mail.try(:fetch, :template) || notification.template

      mail(
        to: to,
        subject: t("notifly.mail_subject.#{@template}")
      ).deliver
    end
  end
end
