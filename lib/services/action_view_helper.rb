class ActionViewHelper
  attr_reader :action_view
  delegate *ActionView::Base.instance_methods, to: :action_view

  def initialize
    notifly_path = File.expand_path(File.dirname(File.dirname(__FILE__))) + '../../app/views/notifly'
    ActionController::Base.prepend_view_path(notifly_path)
    @action_view = ActionView::Base.new(ActionController::Base.view_paths)
    @action_view.extend ApplicationHelper

    @action_view.class_eval do
      include Notifly::Engine.routes.url_helpers

      def protect_against_forgery?
        false
      end
    end
  end
end
