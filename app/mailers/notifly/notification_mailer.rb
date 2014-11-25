module Notifly
  class NotificationMailer < ActionMailer::Base
    default from: "from@example.com"

    def notifly(to: nil, notification: nil)
      @notification = notification

      mail(to: to).deliver
    end
  end
end
