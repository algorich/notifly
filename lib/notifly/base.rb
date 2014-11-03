require 'notifly/model_options/options'
require 'notifly/injector'

module Notifly
  module Base
    module ClassMethods
      def notifly(options = {})
        @@notifly_model_options ||= NotiflyModelOptions.new
        @@notifly_model_options.assign(options: options, to: self)
      end

      def get_notifly
        @@notifly_model_options
      end
    end

    module InstanceMethods
      def notifly
        self.class.get_notifly
      end
    end

    def self.included(base)
      base.extend ClassMethods
      base.include InstanceMethods

      base.class_eval do
        include ActiveSupport::Callbacks
      end
    end
  end
end
