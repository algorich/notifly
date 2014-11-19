require_dependency "notifly/application_controller"

module Notifly
  class NotificationsController < ApplicationController
    def counter
      @counter = count_unseen
    end

    def update_counter
      update_all_seen_pages(seen: true)
      @counter = count_unseen
      render 'counter'
    end

    def index
      @notifications = current_user_notifications.page(params[:page]).per(Notifly.per_page)
    end


    def read_specific
      update_all_seen_pages(read: true)
    end

    def read
      @notification = Notifly::Notification.find(params[:notification_id])
      @notification.update(read: true)
    end

    private
      def current_user_notifications
        Notifly::Notification.all_from(current_user).order('created_at DESC')
      end

      def count_unseen
        Notifly::Notification.unseen_from(current_user).count
      end

      def update_all_seen_pages(attributes)
        size = params[:pages].to_i * Notifly.per_page
        @notifications = current_user_notifications.limit(size)
        @notifications.update_all attributes
      end
  end
end
