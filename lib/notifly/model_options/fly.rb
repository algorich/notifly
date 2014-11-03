class Fly
  attr_accessor :before, :after, :template, :sender, :receiver, :target, :if, :unless

  def initialize(options={})
    options.each { |key, value| try "#{key}=", value }
  end

  def hook
    if @before.nil?
      :after
    else
      :before
    end
  end

  def method
    self.send(hook)
  end
end
