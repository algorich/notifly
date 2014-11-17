require 'notifly/engine'
require 'notifly/railtie'

module Notifly
  # How many notifications per page.
  mattr_accessor :per_page
  @@per_page = 10

  # Default way to setup Notifly. Run rails generate notifly:install to create
  # a fresh initializer with all configuration values.
  def self.setup
    yield self
  end
end
