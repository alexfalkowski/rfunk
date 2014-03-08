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
            raise_expected_type(name, value, type)
            create_immutable(variable_name(name), value)
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
        raise_not_found(key, attributes)
        set_variable(attributes[key], key, value)
      }
    end

    def set_variable(attribute, key, value)
      raise_expected_type(key, value, attribute.type)
      self.instance_variable_set(variable_name(key), value)
    end

    def variable_name(name)
      "@#{name}"
    end

    def create_immutable(variable_name, value)
      self.class.new.tap { |object|
        self.instance_variables.select { |v| v != variable_name }.each { |v|
          previous_value = self.instance_variable_get(v)
          object.instance_variable_set(v, previous_value)
        }

        object.instance_variable_set(variable_name, value)
        object.deep_freeze
      }
    end

    def raise_expected_type(name, value, type)
      unless value.instance_of?(type)
        message = "Expected a type of '#{type}' for attribute '#{name}'"
        raise TypeError, message
      end
    end

    def raise_not_found(key, attributes)
      unless attributes.key?(key)
        message = "Attribute with name '#{key}' does not exist. The only available attributes are '#{attributes.keys}'"
        raise RFunk::NotFoundError, message
      end
    end
  end
end
