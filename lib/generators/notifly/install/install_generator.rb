require File.expand_path('../utils', __FILE__)

module Notifly
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Generators::Utils::InstanceMethods
      source_root File.expand_path('../templates', __FILE__)
      argument :namespace, type: :string, required: false, desc: 'Notifly url namespace'

      desc 'Notifly installation generator'

      def mount_engine
        namespace = ask_for('Where do you want to mount Notifly?', 'notifly', namespace)
        route("mount Notifly::Engine => '/#{namespace}', as: 'notifly'")
      end

      def copy_config
        template "config/initializers/notifly.rb"
      end
    end
  end
end
