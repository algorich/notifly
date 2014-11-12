require_relative '../../app/helpers/notifly/view_helper'
require_relative 'models/base'

module Notifly
  class Railtie < Rails::Railtie
    initializer 'Notifly.view_helpers' do
      ActionView::Base.send :include, ViewHelper
    end

    initializer 'Notifly.active_model_helpers' do
      ActiveRecord::Base.send :include, Notifly::Models::Base
    end
  end
end