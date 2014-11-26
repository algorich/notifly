require 'notifly/engine'
require 'notifly/railtie'
require 'font-awesome-rails'

module Notifly
  # How many notifications per page.
  mattr_accessor :per_page
  @@per_page = 10

  mattr_accessor :icon_size
  @@icon_size = '2x'

  mattr_accessor :icon
  @@icon = 'bell'

  mattr_accessor :icon_empty
  @@icon_empty = 'bell-o'

  mattr_accessor :mailer_sender
  @@mailer_sender = 'change-me-at-config-initializers-notifly@exemple.com'

  # Default way to setup Notifly. Run rails generate notifly:install to create
  # a fresh initializer with all configuration values.
  def self.setup
    yield self
  end
end
