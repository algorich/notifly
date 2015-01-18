class DummyObject < ActiveRecord::Base
  has_many :posts

  notifly default_values: { receiver: :self }
  notifly after:  :create,   template: :create,  if: :is_smart?
  notifly after:  :save,     template: :save,    if: :is_smart?
  notifly after:  :update,   template: :update,  if: :is_smart?

  notifly before: :destroy,  template: :destroy_smart, mail: true,  if: :is_smart?

  notifly before: :destroy,  template: :destroy_dummy, mail: { only: true,
    template: :default }, unless: :is_smart?
  notifly after:  :be_smart, template: :be_smart,      mail: { only: true,
    template: :default }, if:     :is_smart?

  notifly after: :buzz, if: :is_smart?

  notifly after: :test_kind, kind: :message
  notifly after: :test_kind, kind: :feed

  notifly after: :test_then, then: -> { self.update name: 'name_after_then' }
  notifly after: :test_then_using_notification, kind: :blastoise,
    then: ->(n) { self.update name: n.kind }

  def be_smart
    self.name = 'smart'
  end

  def buzz
    'buzz'
  end

  def is_smart?
    name == 'smart'
  end

  def test_kind
    # code
    true
  end

  def test_then
    #code
  end

  def test_then_using_notification
    #code
  end
end
