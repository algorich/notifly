require_dependency "notifly/application_controller"

module Notifly
  class NotificationsController < ApplicationController
    def count
      @counter = Notifly::Notification.unread_from(find_receiver).count
    end

    def index
      @notifications = Notifly::Notification.all_from(find_receiver).
        order('created_at DESC').page params[:page]
    end

    private
      def find_receiver
        params[:receiver_type].constantize.find(params[:receiver_id])
      end
  end
end
