module Notifly
  class Notification < ActiveRecord::Base
    belongs_to :target, polymorphic: true
    belongs_to :sender, polymorphic: true
    belongs_to :receiver, polymorphic: true

    validates :receiver, :template, presence: true
  end
end
