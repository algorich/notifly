module Notifly
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      source_root File.expand_path('../../../../../app/views/notifly', __FILE__)

      class_option :layout, type: :boolean, default: false,
        desc: 'Include/Remove layout files.'
      class_option :mail, type: :boolean, default: false,
        desc: 'Include/Remove mails templates files.'
      class_option :notification, type: :boolean, default: false,
        desc: 'Include/Remove notifications templates files.'

      def copy_views
        notifications_templates if options.notification?
        notifications_mails_templates if options.mail?
        layout_files if options.layout?
      end

      private
        def main_app_path
          'app/views/notifly'
        end

        def notifications_templates
          directory 'templates/notifications', "#{main_app_path}/templates/notifications"
        end

        def notifications_mails_templates
          directory 'templates/mails', "#{main_app_path}/templates/mails"
        end

        def layout_files
          directory 'layouts', "#{main_app_path}/layouts"
        end
    end
  end
end
