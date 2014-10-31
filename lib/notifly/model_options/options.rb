require 'notifly/model_options/fly'

class NotiflyModelOptions
  attr_accessor :template, :sender, :receiver, :target, :if, :unless

  def initialize
    @flies = []
  end

  def assign(options={})
    if options[:default_values]
      options[:default_values].each { |key, value| try "#{key}=", value }
    else
      @flies << Fly.new(options)
    end
  end
end