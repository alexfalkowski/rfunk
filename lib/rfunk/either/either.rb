module RFunk
  class Either
    def initialize(value)
      @value = value
    end

    def result
      case value
      when RFunk::Some, RFunk::None
        value
      else
        RFunk.option(value)
      end
    end

    alias identity result

    def ==(other)
      other.result == result
    end

    private

    attr_reader :value
  end

  class << self
    def either(value)
      if lambda?(value)
        either_with_lambda(value)
      else
        either_with_value(value)
      end
    end

    private

    def lambda?(value)
      value.respond_to?(:lambda?) && value.lambda?
    end

    def either_with_lambda(lambda)
      RFunk.success(lambda.call)
    rescue StandardError => e
      RFunk.failure(e)
    end

    def either_with_value(value)
      if value
        RFunk.success(value)
      else
        RFunk.failure(value)
      end
    end
  end
end
