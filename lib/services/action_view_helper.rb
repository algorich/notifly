module Notifly
  class ActionViewHelper
    attr_reader :action_view
    delegate *ActionView::Base.instance_methods.reject { |m| [:object_id, :__send__].include? m }, to: :action_view

    def initialize
      notifly_path = File.expand_path(File.dirname(File.dirname(__FILE__))) + '../../app/views/notifly'
      ActionController::Base.prepend_view_path(notifly_path)
      @action_view = ActionView::Base.new(ActionController::Base.view_paths)
      @action_view.extend ApplicationHelper

      @action_view.class_eval do
        include Notifly::Engine.routes.url_helpers
        Dir[File.join(Rails.root, 'app/helpers/**/*.rb')].each do |f|
          require f
          include f.split('/').last.split('.').first.camelize.constantize
        end

        def protect_against_forgery?
          false
        end

        def main_app
          Rails.application.routes.url_helpers
        end
      end
    end
  end
end
