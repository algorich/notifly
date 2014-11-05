require_relative '../../app/helpers/notifly/view_helper'

module Notifly
  class Railtie < Rails::Railtie
    initializer 'Notifly.view_helpers' do
      ActionView::Base.send :include, ViewHelper
    end
  end
end