require_dependency "notifly/application_controller"

module Notifly
  class NotificationsController < ApplicationController
    def counter
      @counter = count_unseen
    end

    def index
      @notifications = current_user_notifications.page(params[:page]).per(Notifly.per_page)
      Notifly::Notification.where(id: @notifications.map(&:id)).update_all(seen: true)
      @counter = count_unseen
    end


    def read_specific
      size = params[:pages].to_i * Notifly.per_page
      @notifications = current_user_notifications.limit(size)
      @notifications.update_all read: true
    end

    def toggle_read
      @notification = Notifly::Notification.find(params[:notification_id])
      @notification.update(read: !@notification.read)
    end

    private
      def current_user_notifications
        Notifly::Notification.all_from(current_user).order('created_at DESC')
      end

      def count_unseen
        Notifly::Notification.unseen_from(current_user).count
      end
  end
end
