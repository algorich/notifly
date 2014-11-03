require 'rails_helper'

module Notifly
  RSpec.describe Notification, :type => :model do
    it { is_expected.to validate_presence_of(:receiver) }
    it { is_expected.to validate_presence_of(:template) }
  end
end
