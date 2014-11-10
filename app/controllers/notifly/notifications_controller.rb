require_dependency "notifly/application_controller"

module Notifly
  class NotificationsController < ApplicationController
    def count
      @counter = Notifly::Notification.unread_from(current_receiver).count
    end

    def index
      @notifications = Notifly::Notification.all_from(current_receiver).
        order('created_at DESC').page params[:page]
    end

    private
      def current_receiver
        @current_receiver = params[:receiver_type].constantize.find(params[:receiver_id])
      end
  end
end
