require 'jquery-rails'
require 'jquery-ui-rails'
require 'kaminari'

module Notifly
  class Engine < ::Rails::Engine
    isolate_namespace Notifly

    config.generators do |g|
      g.test_framework :rspec
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end
  end
end
