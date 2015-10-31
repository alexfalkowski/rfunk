module RFunk
  class ErrorChecking
    def raise_condition_error(type, value)
      fail type, 'The condition was not met!' unless value
    end

    def raise_expected_return_type(name, value, type)
      raise_return_type_with_message name, value, type, 'return'
    end

    def raise_expected_attribute_type(name, value, type)
      raise_return_type_with_message name, value, type, 'attribute'
    end

    def raise_expected_parameter_type(name, value, type)
      raise_return_type_with_message name, value, type, 'parameter'
    end

    def raise_not_found(key, attributes)
      return if attributes.key?(key)
      message = "Attribute with name '#{key}' does not exist. The only available attributes are '#{attributes.keys}'"
      fail RFunk::NotFoundError, message
    end

    def raise_immutable(options, variable)
      keys = options.keys.select { |k| variable.key?(k) }
      message = "Could not set variables '#{keys}', because variables are immutable."
      fail RFunk::ImmutableError, message if keys.any?
    end

    private

    def raise_return_type_with_message(name, value, type, message)
      case value
      when RFunk::Some
        expected_type?(name, value.value, type, message)
      when RFunk::None
      else
        expected_type?(name, value, type, message)
      end
    end

    def expected_type?(name, value, type, message)
      case type
      when RFunk::Some
        raise_type(name, value, type.value, message)
      when RFunk::None
      else
        raise_type(name, value, type, message)
      end
    end

    def raise_type(name, value, type, message)
      return if value.is_a?(type)
      fail TypeError, "Expected a type of '#{type}' for #{message} '#{name}'"
    end
  end
end
