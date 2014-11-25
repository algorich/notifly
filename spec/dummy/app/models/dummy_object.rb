class DummyObject < ActiveRecord::Base
  has_many :posts

  notifly default_values: { receiver: :self }
  notifly after:  :create,   template: :create,  if: :is_smart?
  notifly after:  :save,     template: :save,    if: :is_smart?
  notifly after:  :update,   template: :update,  if: :is_smart?

  notifly before: :destroy,  template: :destroy_smart, mail: true,  if: :is_smart?

  notifly before: :destroy,  template: :destroy_dummy, mail: { only: true },
    unless: :is_smart?
  notifly after:  :be_smart, template: :be_smart,      mail: { only: true },
    if:     :is_smart?

  notifly after: :buzz, if: :is_smart?

  def be_smart
    self.name = 'smart'
  end

  def buzz
    'buzz'
  end

  def is_smart?
    name == 'smart'
  end
end
