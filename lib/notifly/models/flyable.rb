require_relative 'options/fly'

module Notifly
  module Models
    module Flyable
      extend ActiveSupport::Concern

      module ClassMethods
        attr_reader :flies, :default_fly, :flyable_callbacks

        def notifly(options = {})
          @flies ||= []
          @flyable_callbacks ||= []

          fly = Notifly::Models::Options::Fly.new options

          if options[:default_values]
            @default_fly = fly
          else
            create_callback_for_class_method_from fly if respond_to? fly.method_name
            @flies << fly
          end
        end

        def method_added(method_name)
          create_callbacks_for method_name
          super
        end

        private
          def create_callbacks_for(method_name)
            method_flies = flies_for method_name

            method_flies.each do |fly|
              create_callback_for_instance_method_from(fly)
            end
          end

          def flies_for(method_name)
            if flies.present?
              flies.select { |fly| fly.method_name == method_name }
            else
              []
            end
          end

          def create_callback_for_class_method_from(fly)
            callback_name = "#{fly.hook}_#{fly.method_name}"
            flyable_callbacks << "#{callback_name}_#{fly.object_id}"

            send(callback_name, if: fly.if, unless: fly.unless) do |record|
              create_notification_for(fly)
            end
          end

          def create_callback_for_instance_method_from(fly)
            notifly_callback_name = format_callback_name_for(fly)

            if not flyable_callbacks.include? notifly_callback_name
              flyable_callbacks << notifly_callback_name

              define_callbacks notifly_callback_name
              set_callback notifly_callback_name, fly.hook, if: fly.if, unless: fly.unless do |record|
                create_notification_for(fly)
              end

              old_method = instance_method(fly.method_name)

              define_method(fly.method_name) do |*args|
                run_callbacks(notifly_callback_name) do
                  old_method.bind(self).call(*args)
                end
              end
            end
          end

          def format_callback_name_for(fly)
            ending_chars = {
              '!' => :_dangerous,
              '?' => :_question
            }

            method_name = fly.method_name.to_s.gsub(/(?<char>[\?|\!])/, ending_chars)

            "notifly_#{fly.hook}_#{method_name}_#{fly.object_id}"
          end
      end

      def create_notification_for(fly)
        new_fly = default_fly.merge(fly)
        Notifly::Notification.create! get_attributes_from(new_fly)
      end

      private
        def default_fly
          self.class.default_fly || Notifly::Models::Options::Fly.new
        end

        def get_attributes_from(fly)
          evaluated_attributes = {}

          fly.attributes.each do |key, value|
            evaluated_attributes[key] = eval_for(key, value)
          end

          evaluated_attributes
        end

        def eval_for(key, value)
          if key.to_sym == :template
            value
          elsif value == :self
            self
          else
            send(value)
          end
        end
    end
  end
end