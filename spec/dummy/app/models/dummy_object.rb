class DummyObject < ActiveRecord::Base
  has_many :posts

  def foo
    p 'foo'
  end

  def buzz
    p 'buzz'
  end
end
