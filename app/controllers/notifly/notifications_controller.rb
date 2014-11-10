require_dependency "notifly/application_controller"

module Notifly
  class NotificationsController < ApplicationController
    def count
      @counter = Notifly::Notification.unread_from(current_user).count
    end

    def index
      @notifications = Notifly::Notification.all_from(current_user).
        order('created_at DESC').page params[:page]
    end
  end
end
