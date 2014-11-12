module Notifly
  module Models
    module Notifiable
      extend ActiveSupport::Concern

      def notifly!(args={})
        Notifly::Notification.create! args.merge(receiver: self)
      end
    end
  end
end