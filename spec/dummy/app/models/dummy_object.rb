class DummyObject < ActiveRecord::Base
  notifly default_values: { sender: :self, receiver: :self }
  
  notifly after: :create , if: -> { self.name == 'foo' }
  notifly after: :create , if: -> { self.name == 'bar' }
  notifly after: :destroy, sender: :foo, if: -> { self.name == 'buzz' }
end