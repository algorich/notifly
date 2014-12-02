require_dependency "notifly/application_controller"

module Notifly
  class NotificationsController < ApplicationController
    def counter
      @counter = count_unseen
    end

    def index
      @notifications = current_user_notifications.page(from: params[:current_notification_id])
      Notifly::Notification.where(id: @notifications.map(&:id)).update_all(seen: true)
      @counter = count_unseen
    end


    def read_specific
      @notifications = current_user_notifications.where('id >= ?', params[:current_notification_id])
      @notifications.update_all read: true
    end

    def toggle_read
      @notification = Notifly::Notification.find(params[:notification_id])
      @notification.update(read: !@notification.read)
    end

    def newest
      @notifications = current_user_notifications.unseen
      @counter = count_unseen
    end

    private
      def current_user_notifications
        current_user.notifly_notifications.not_only_mail
      end

      def count_unseen
        current_user_notifications.unseen.count
      end
  end
end
