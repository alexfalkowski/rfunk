module RFunk
  class ErrorChecking
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
