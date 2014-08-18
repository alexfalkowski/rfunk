module RFunk
  module AttributeDefinition
    def attribute(name, type, options = {})
      AttributeVariable.new.add(instance: self,
                                name: name,
                                type: type,
                                options: options)

      define_method(name) { |value = nil|
        if value
          ErrorChecking.new.raise_expected_attribute_type(name, value, type)
          Immutable.new.create(instance: self,
                               variable_name: variable_name(name),
                               value: value)
        else
          Option(self.instance_variable_get(variable_name(name)))
        end
      }
    end
  end
end
