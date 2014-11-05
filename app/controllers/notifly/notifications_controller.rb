require_dependency "notifly/application_controller"

module Notifly
  class NotificationsController < ApplicationController
    def count
      @counter = Notifly::Notification.all_from(find_receiver).count
    end

    private
      def find_receiver
        params[:receiver_type].constantize.find(params[:receiver_id])
      end
  end
end
