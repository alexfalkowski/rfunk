module RFunk
  class None < RFunk::Option
    include Singleton

    def value
      RFunk::None.instance
    end

    def or(other)
      RFunk.option(other)
    end

    def pipe(&_block)
      self
    end

    def method_missing(_method, *_arguments, &_block)
      self
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

    def key
      :none
    end

    protected

    def enum
      []
    end
  end

  class << self
    def none
      RFunk::None.instance
    end
  end
end
