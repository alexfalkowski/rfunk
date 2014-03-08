module RFunk
  class Some
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
      other.value == value
    end
  end

  def Some(value)
    Option(value)
  end
end
