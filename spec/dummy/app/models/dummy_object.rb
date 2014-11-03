class DummyObject < ActiveRecord::Base
  notifly default_values: { sender: :self, receiver: :self, template: :bar }

  # notifly after: :create , template: :foo, if: -> { self.name == 'foo' }
  # notifly after: :create , if: -> { self.name == 'bar' }
  # notifly before: :destroy, sender: :foo, if: -> { self.name == 'buzz' }

  def foo
    p 'foo'
  end
  notifly before: :foo, template: 1, if: -> { self.name == 'foo' }
  notifly after: :foo, template: 2, if: -> { self.name == 'bar' }
  notifly after: :foo, template: 3, if: -> { self.name == 'buzz' }

  def buzz
    p 'buzz'
  end
  notifly before: :buzz, template: 4
  notifly after: :buzz, template: 5, unless: -> { self.name == 'foo' }
end
