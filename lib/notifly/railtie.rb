require 'rails'

# Railtie class to automatically include {ActiveSpy::Spy} in all
# +ActiveRecord::Base+
#
class Railtie < Rails::Railtie
  initializer 'notifly.active_record' do
    ActiveSupport.on_load(:active_record) do
      include Notifly::Base
    end
  end
end