module Notifly
  class Notification < ActiveRecord::Base
    belongs_to :target, polymorphic: true
    belongs_to :sender, polymorphic: true
    belongs_to :receiver, polymorphic: true

    validates :receiver, :template, presence: true

    before_validation :convert_data

    def data
      YAML.load(read_attribute(:data))
    end

    private
      def convert_data
        self.data = read_attribute(:data).to_json
      end
  end
end
