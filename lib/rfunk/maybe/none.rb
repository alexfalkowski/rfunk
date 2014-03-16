module RFunk
  class None < Option
    include Singleton

    def value(default = None())
      Option(default)
    end

    def or(other)
      Option(other)
    end

    def method_missing(method, *arguments, &block)
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

    protected

    def enum
      []
    end
  end

  def None(value = nil)
    Option(value)
  end
end
