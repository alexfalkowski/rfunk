module RFunk
  module Attribute
    def self.included(base)
      base.extend(RFunk::AttributeDefinition)
      base.extend(RFunk::AttributeFunction)
    end

    def initialize(options = {})
      with_defaults
      with_attributes(options)
    end

    private

    def attributes
      RFunk::AttributeVariable.new.attributes(self.class)
    end

    def with_defaults
      attributes.each { |key, attribute|
        value = attribute.options[:default]
        set_variable(attribute, key, value) if value
      }
    end

    def with_attributes(options)
      options.each { |key, value|
        RFunk::ErrorChecking.new.raise_not_found(key, attributes)
        set_variable(attributes[key], key, value)
      }
    end

    def set_variable(attribute, key, value)
      RFunk::ErrorChecking.new.raise_expected_attribute_type(key, value, attribute.type)
      self.instance_variable_set(variable_name(key), value)
    end

    def variable_name(name)
      "@#{name}"
    end
  end
end
