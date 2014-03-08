module RFunk
  class Value
    def initialize(value)
      @value = value
    end

    def result
      case value
      when Some, None
        value
      else
        Option(value)
      end
    end

    def ==(other)
      other.result == result
    end

    private

    attr_reader :value
  end
end
