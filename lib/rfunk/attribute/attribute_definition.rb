module RFunk
  module AttributeDefinition
    def attribute(name, type, options = {})
      RFunk::AttributeVariable.new.add(instance: self, name: name, type: type, options: options)
      create_method(name, type)
    end

    private

    def create_method(name, type)
      define_method(name) do |value = nil|
        if value
          RFunk::ErrorChecking.new.raise_expected_attribute_type(name, value, type)
          RFunk::Immutable.new.create(instance: self, variable_name: variable_name(name), value: value)
        else
          RFunk.option(instance_variable_get(variable_name(name)))
        end
      end
    end
  end
end
