module RFunk
  module Attribute
    ATTRIBUTES_VARIABLE_NAME = '@attributes'

    def self.included(base)
      base.extend(ClassMethods)
    end

    def initialize(options = {})
      with_defaults
      with_attributes(options)
    end

    module ClassMethods
      def attribute(name, type, options = {})
        add_attribute(name, type, options)

        self.send :define_method, name do |value = nil|
          if value
            ErrorChecking.new.raise_expected_type(name, value, type)
            Immutable.new.create(instance: self,
                                 variable_name: variable_name(name),
                                 value: value)
          else
            Option(self.instance_variable_get(variable_name(name)))
          end
        end
      end

      private

      def add_attribute(name, type, options)
        attributes = self.instance_variable_get(ATTRIBUTES_VARIABLE_NAME) || {}
        attributes[name] = AttributeType.new(name, type, options)
        self.instance_variable_set(ATTRIBUTES_VARIABLE_NAME, attributes)
      end
    end

    private

    def attributes
      self.class.instance_variable_get(ATTRIBUTES_VARIABLE_NAME)
    end

    def with_defaults
      attributes.each { |key, attribute|
        value = attribute.options[:default]
        set_variable(attribute, key, value) if value
      }
    end

    def with_attributes(options)
      options.each { |key, value|
        ErrorChecking.new.raise_not_found(key, attributes)
        set_variable(attributes[key], key, value)
      }
    end

    def set_variable(attribute, key, value)
      ErrorChecking.new.raise_expected_type(key, value, attribute.type)
      self.instance_variable_set(variable_name(key), value)
    end

    def variable_name(name)
      "@#{name}"
    end
  end
end
