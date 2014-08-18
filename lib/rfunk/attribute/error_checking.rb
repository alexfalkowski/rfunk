module RFunk
  class ErrorChecking
    def raise_condition_error(type, value)
      raise type, 'The condition was not met!' unless value
    end

    def raise_expected_return_type(name, value, type)
      raise_return_type_with_message name, value, type, 'return'
    end

    def raise_expected_type(name, value, type)
      raise_return_type_with_message name, value, type, 'attribute'
    end

    def raise_not_found(key, attributes)
      unless attributes.key?(key)
        message = "Attribute with name '#{key}' does not exist. The only available attributes are '#{attributes.keys}'"
        raise RFunk::NotFoundError, message
      end
    end

    def raise_immutable(options, variable)
      keys = options.keys.select { |k| variable.has_key?(k) }
      message = "Could not set variables '#{keys}', because variables are immutable."
      raise ImmutableError, message if keys.any?
    end

    private

    def raise_return_type_with_message(name, value, type, message)
      case value
      when Some
        expected_type?(name, value.value, type, message)
      when None
      else
        expected_type?(name, value, type, message)
      end
    end

    def expected_type?(name, value, type, message)
      case type
      when Some
        raise_type(name, value, type.value, message)
      when None
      else
        raise_type(name, value, type, message)
      end
    end

    def raise_type(name, value, type, message)
      unless value.is_a?(type)
        raise TypeError, "Expected a type of '#{type}' for #{message} '#{name}'"
      end
    end
  end
end
