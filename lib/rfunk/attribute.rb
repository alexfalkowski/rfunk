module RFunk
  module Attribute
    ATTRIBUTES_VARIABLE_NAME = '@attributes'

    def self.included(base)
      base.extend(ClassMethods)
    end

    def initialize(options = {})
      attributes = self.class.instance_variable_get(ATTRIBUTES_VARIABLE_NAME)

      options.each { |key, value|
        raise_not_found(key, attributes)

        type = attributes[key]

        raise_expected_type(key, value, type)

        self.instance_variable_set(variable_name(key), value)
      }
    end

    module ClassMethods
      def attribute(name, type)
        add_attribute(name, type)

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

      def add_attribute(name, type)
        attributes = self.instance_variable_get(ATTRIBUTES_VARIABLE_NAME) || {}
        attributes[name] = type
        self.instance_variable_set(ATTRIBUTES_VARIABLE_NAME, attributes)
      end
    end

    private

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
      raise TypeError, "Expected a type of '#{type}' for attribute '#{name}'" unless value.instance_of?(type)
    end

    def raise_not_found(key, attributes)
      raise RFunk::NotFoundError, "Attribute with name '#{key}' does not exist. The only available attributes are '#{attributes}'" unless attributes.key?(key)
    end
  end
end
