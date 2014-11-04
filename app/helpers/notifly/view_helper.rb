module Notifly
  module ViewHelper
    def notiflies_for(user)
      render partial: 'notifly/notiflies', locals: { counter: Notifly::Notification.all_from(user).count }
    end
  end
end
