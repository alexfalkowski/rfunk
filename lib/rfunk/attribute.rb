module RFunk
  module Attribute
    ATTRIBUTES_VARIABLE_NAME = '@attributes'

    def self.included(base)
      base.extend(ClassMethods)
    end

    def initialize(options = {})
      attributes = self.class.instance_variable_get(ATTRIBUTES_VARIABLE_NAME)

      options.each { |key, value|
        unless attributes.key?(key)
          raise "Attribute with name '#{key}' does not exist. The only available attributes are '#{attributes}'"
        end

        type = attributes[key]

        raise "Expected a type of '#{type}' for attribute '#{key}'" unless value.instance_of?(type)

        variable_name = "@#{key}"
        self.instance_variable_set(variable_name, value)
      }
    end

    module ClassMethods
      def attribute(name, type)
        attributes = self.instance_variable_get(ATTRIBUTES_VARIABLE_NAME) || {}
        attributes[name] = type
        self.instance_variable_set(ATTRIBUTES_VARIABLE_NAME, attributes)

        variable_name = "@#{name}"

        self.send :define_method, name do |value = nil|
          if value
            raise "Expected a type of '#{type}' for attribute '#{name}'" unless value.instance_of?(type)

            self.class.new.tap { |object|
              self.instance_variables.select { |v| v != variable_name }.each { |v|
                previous_value = self.instance_variable_get(v)
                object.instance_variable_set(v, previous_value)
              }

              object.instance_variable_set(variable_name, value)
              object.deep_freeze
            }
          else
            Some(self.instance_variable_get(variable_name))
          end
        end
      end
    end
  end
end
