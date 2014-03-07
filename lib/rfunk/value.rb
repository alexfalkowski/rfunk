module RFunk
  class Value
    def initialize(value)
      @value = value
    end

    def result
      Some(value)
    end

    private

    attr_reader :value
  end
end
