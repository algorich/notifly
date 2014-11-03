module Notifly
  class Notification < ActiveRecord::Base
    belongs_to :target
    belongs_to :sender
    belongs_to :receiver

    validates :receiver, :template, presence: true
  end
end
