module Notifly
  class Notification < ActiveRecord::Base
    belongs_to :target, polymorphic: true
    belongs_to :sender, polymorphic: true
    belongs_to :receiver, polymorphic: true

    before_validation :convert_data, :set_template

    scope :all_from,      -> (receiver) { where(receiver: receiver) }
    scope :unseen,        -> { where(seen: false) }
    scope :not_only_mail, -> { where.not(mail: 'only') }
    scope :page,     ->(from: nil) do
      id = from.try(:id) || from

      page = order('created_at DESC')
      page = page.where('id < ?', id) if id.present?
      page.limit(Notifly.per_page)
    end

    validates :receiver, :template, :mail, presence: true

    def data
      YAML.load(read_attribute(:data))
    end

    private
      def convert_data
        self.data = read_attribute(:data).to_json
      end

      def set_template
        self.template ||= :default
      end
  end
end
