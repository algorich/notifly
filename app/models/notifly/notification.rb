module Notifly
  class Notification < ActiveRecord::Base
    belongs_to :target, polymorphic: true
    belongs_to :sender, polymorphic: true
    belongs_to :receiver, polymorphic: true

    before_validation :set_defaults
    after_create :send_to_receiver, if: -> { Notifly.websocket }

    scope :all_from,      -> (receiver) { where(receiver: receiver) }
    scope :unseen,        -> { where(seen: false) }
    scope :not_only_mail, -> { where.not(mail: 'only') }
    scope :limited,       -> { limit(Notifly.per_page) }
    scope :ordered,       -> { order('notifly_notifications.created_at DESC') }
    scope :newer,         ->(than: nil) do
      return ordered if than.blank?

      reference = find_by(id: than)
      ordered.where('notifly_notifications.created_at > ?', reference.created_at).where.not(id: reference)
    end
    scope :older,         ->(than: nil) do
      reference = find_by(id: than)

      ordered.
      where('notifly_notifications.created_at < ?', reference.created_at).
      where.not(id: reference)
    end
    scope :between,       ->(first, last) do
      notifications = where(id: [first, last])
      where(created_at: (notifications.first.created_at..notifications.last.created_at))
    end

    validates :receiver, :template, :mail, :kind, presence: true

    serialize :data, JSON

    private
      def set_defaults
        self.mail     ||= :never
        self.kind     ||= :notification
        self.template ||= :default
      end

      def send_to_receiver
        Notifly::NotificationChannel.new(self.receiver_id).trigger(self) if self.kind == 'notification'
      end
  end
end
