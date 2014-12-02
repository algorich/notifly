module Notifly
  module ViewHelper
    def notiflies
      notiflies_for current_user
    end

    def notiflies_for(receiver)
      render partial: 'notifly/layouts/notifly', locals: { receiver: receiver }
    end

    def notifly_icon(have_notifications=false)
      icon = have_notifications ? Notifly.icon : Notifly.icon_empty
      size = Notifly.icon_size
      fa_icon "#{icon} #{size}"
    end

    def link_to_next_page(page, text, options={})
      last_notification_from_page = page.last
      link_to text, notifications_path(current_notification_id: last_notification_from_page.id),
        options
    end
  end
end
