require_relative 'notifiable'
require_relative 'flyable'

module Notifly
  module Models
    module Base
      extend ActiveSupport::Concern

      include Notifly::Models::Notifiable
      include Notifly::Models::Flyable
    end
  end
end