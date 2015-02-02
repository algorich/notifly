module Notifly
  class NotificationChannel
    def initialize(user_id)
      @user_id = user_id
      @channel = WebsocketRails.users[@user_id.to_s]
      @action_view = ActionViewHelper.new
    end

    def trigger(notification)
      @channel.send_message 'notifly.notifications.new',
        { message: render(notification), id: notification.id }
    end

    def render(notification)
      @action_view.render partial: 'layouts/notification',
        locals: { notification: notification }
    end
  end
end