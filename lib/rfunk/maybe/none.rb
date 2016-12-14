module RFunk
  class None < RFunk::Option
    include Singleton

    def value(default = None())
      RFunk::Option(default)
    end

    def or(other)
      RFunk::Option(other)
    end

    def method_missing(_method, *_arguments, &_block)
      self
    end

    def respond_to_missing?(method_name, include_private = false)
      super
    end

    def coerce(other)
      [other, 0]
    end

    def to_str
      ''
    end

    def to_ary
      []
    end

    def to_hash
      {}
    end

    protected

    def enum
      []
    end
  end

  def None(value = nil)
    RFunk::Option(value)
  end
end
