require 'notifly/model_options/options'

module Notifly
  module Base
    module ClassMethods
      def notifly(options = {})
        @@notifly_model_options ||= NotiflyModelOptions.new
        @@notifly_model_options.assign(options)
        
        define_method :notifly do 
          @@notifly_model_options
        end
      end
    end

    def self.included(base)
       base.extend ClassMethods
     end
  end
end