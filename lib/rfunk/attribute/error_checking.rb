module RFunk
  class ErrorChecking
    def raise_condition_error(type, value)
      raise type, 'The condition was not met!' unless value
    end

    def raise_expected_type(name, value, type)
      case value
      when Some
        expected_type?(name, value.value, type)
      when None
      else
        expected_type?(name, value, type)
      end
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

    def expected_type?(name, value, type)
      unless value.is_a?(type)
        message = "Expected a type of '#{type}' for attribute '#{name}'"
        raise TypeError, message
      end
    end
  end
end
