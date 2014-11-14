module Notifly
  module Models
    module Options
      class Fly
        attr_accessor :before, :after, :template, :sender, :receiver, :target,
          :if, :unless, :data

        def initialize(options={})
          options = options.fetch(:default_values, options)
          options.each { |key, value| try "#{key}=", value }
        end

        def hook
          if @before.nil?
            :after
          else
            :before
          end
        end

        def method_name
          self.send(hook)
        end

        def attributes
          instance_values.reject { |key| [hook, :if, :unless].include? key.to_sym  }
        end

        def merge(fly)
          raise TypeError, "#{fly} is not a Fly" unless fly.is_a? self.class

          Notifly::Models::Options::Fly.new attributes.merge(fly.attributes)
        end
      end
    end
  end
end