require_dependency "notifly/application_controller"

module Notifly
  class NotificationsController < ApplicationController
    def index
      @notifications = scoped_notifications
      @notifications.update_all(seen: true) if params[:mark_as_seen] == 'true'

      @counter = count_unseen
      @scope_param = scope_param
    end

    def read
      if params[:first_notification_id].present? and params[:last_notification_id].present?
        @notifications = notifications_between
        @notifications.update_all(read: true)
      end
    end

    def toggle_read
      @notification = Notifly::Notification.find(params[:notification_id])
      @notification.update(read: !@notification.read)
    end

    def seen
      if params[:first_notification_id].present? and params[:last_notification_id].present?
        @notifications = notifications_between
        @notifications.update_all(seen: true)
      end
      @counter = count_unseen
    end

    private
      def scoped_notifications
        current_user_notifications.send(scope_param, than: params[:reference_notification_id])
      end

      def scope_param
        return params[:scope] if ['older', 'newer'].include?(params[:scope])
      end

      def current_user_notifications
        @user = current_user
        @user.notifly_notifications.not_only_mail
      end

      def count_unseen
        current_user_notifications.unseen.count
      end

      def notifications_between
        current_user_notifications.between(params[:first_notification_id],
          params[:last_notification_id])
      end
  end
end
