require 'jquery-rails'
require 'jquery-ui-rails'
require 'kaminari'

module Notifly
  class Engine < ::Rails::Engine
    isolate_namespace Notifly

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
