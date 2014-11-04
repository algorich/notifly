class DummyObject < ActiveRecord::Base
  def foo
    p 'foo'
  end

  def buzz
    p 'buzz'
  end
end
