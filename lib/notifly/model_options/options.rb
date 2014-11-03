require 'notifly/model_options/fly'

class NotiflyModelOptions
  attr_accessor :template, :sender, :receiver, :target, :if, :unless

  def initialize
    @flies = []
  end

  def assign(options: {}, to: nil)
    if options[:default_values]
      options[:default_values].each { |key, value| try "#{key}=", value }
    else
      fly = Fly.new(options)
      @flies << fly

      set_fly_hook(fly, to)
    end
  end

  def set_fly_hook(fly, klass)
    call_back_name = "notifly_#{fly.hook}_#{fly.method}_#{@flies.count}"

    klass.class_eval do
      define_callbacks call_back_name
      set_callback call_back_name, fly.hook, if: fly.if, unless: fly.unless do
        notifly.create_notification_for(object: self, fly: fly)
      end

      old_foo = instance_method(fly.method)

      define_method(fly.method) do |*args|
        run_callbacks(call_back_name) do
          old_foo.bind(self).call(*args)
        end
      end
    end
  end

  def create_notification_for(object: nil, fly: nil)
    puts 'Creating notification'
  end
end
