module Notifly
  module Base
    extend ActiveSupport::Concern

    module ClassMethods
      def notifly(options = {})
      end
    end
  end
end

ActiveRecord::Base.send :include, Notifly::Base