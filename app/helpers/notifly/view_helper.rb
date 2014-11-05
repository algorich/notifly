module Notifly
  module ViewHelper
    def notiflies_for(receiver)
      render partial: 'notifly/notiflies', locals: { receiver: receiver }
    end
  end
end
