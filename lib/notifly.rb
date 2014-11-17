require 'notifly/engine'
require 'notifly/railtie'

module Notifly
  # How many notifications per page.
  mattr_accessor :per_page
  @@per_page = 10
end
