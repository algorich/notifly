module Notifly
  module ViewHelper
    def notiflies
      notiflies_for current_user
    end

    def notiflies_for(receiver)
      render partial: 'notifly/notiflies', locals: { receiver: receiver }
    end
  end
end
