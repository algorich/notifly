module Notifly
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      source_root File.expand_path('../../../../../app/views/notifly', __FILE__)
      class_option :layout, type: :boolean, default: false, desc: 'Include layout files.'

      def copy_views
        copy_file 'templates/_default.html.erb', "#{main_app_path}/templates/_default.html.erb"
        layout_files if options.layout?
      end

      private
        def main_app_path
          'app/views/notifly'
        end

        def layout_files
          directory 'layouts', "#{main_app_path}/layouts"
        end
    end
  end
end
