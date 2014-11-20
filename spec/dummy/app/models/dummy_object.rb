class DummyObject < ActiveRecord::Base
  has_many :posts

  notifly default_values: { receiver: :self }
  notifly after:  :create,  template: :create,  if: :is_smart?
  notifly after:  :save,    template: :save,    if: :is_smart?
  notifly after:  :update,  template: :update,  if: :is_smart?
  notifly before: :destroy, template: :destroy, if: :is_smart?

  notifly after: :buzz, if: :is_smart?

  def buzz
    'buzz'
  end

  def is_smart?
    name == 'smart'
  end
end
