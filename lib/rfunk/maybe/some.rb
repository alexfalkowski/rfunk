module RFunk
  class Some < Option
    def initialize(value)
      @value = value
    end

    def value(_ = None())
      @value
    end

    def or(_)
      self
    end

    def method_missing(method, *arguments, &block)
      Option(value.send(method, *arguments, &block))
    end

    def ==(other)
      return false unless self.class == other.class

      value == other.value
    end

    def <=>(other)
      value <=> other.value
    end

    def coerce(other)
      [other, value]
    end

    def to_str
      value
    end

    protected

    def enum
      [value]
    end
  end

  def Some(value)
    Option(value)
  end
end
