module RFunk
  class Value
    def initialize(value)
      @value = value
    end

    def result
      Option(value)
    end

    private

    attr_reader :value
  end
end
