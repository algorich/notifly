class SiteController < ApplicationController
  def index
  end

  def create_notification
    Notifly::Notification.create! receiver: current_user
    render nothing: true
  end
end
