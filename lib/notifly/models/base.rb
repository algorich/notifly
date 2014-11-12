require_relative 'notifiable'

module Notifly
  module Models
    module Base
      extend ActiveSupport::Concern

      include Notifly::Models::Notifiable
    end
  end
end