require_dependency "notifly/application_controller"

module Notifly
  class NotificationsController < ApplicationController
    def count
      @counter = Notifly::Notification.unread_from(current_user).count
    end

    def index
      @notifications = current_user_notifications.page(params[:page]).per(Notifly.per_page)
    end

    def read_specific
      size = params[:pages].to_i * Notifly.per_page
      @notifications = current_user_notifications.limit(size)
      @notifications.update_all(read: true)
    end

    def read
      @notification = Notifly::Notification.find(params[:notification_id])
      @notification.update(read: true)
    end

    private
      def current_user_notifications
        Notifly::Notification.all_from(current_user).order('created_at DESC')
      end
  end
end
