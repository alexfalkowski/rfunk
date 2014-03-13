module RFunk
  class Some < Option
    attr_reader :value

    def initialize(value)
      @value = value
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

    protected

    def enum
      [value]
    end
  end

  def Some(value)
    Option(value)
  end
end
