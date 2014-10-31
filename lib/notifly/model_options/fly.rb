class Fly
  attr_accessor :after, :template, :sender, :receiver, :target, :if, :unless

  def initialize(options={})
    options.each { |key, value| try "#{key}=", value }
  end
end