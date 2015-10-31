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
        RFunk::Option(value)
      end
    end

    def ==(other)
      other.result == result
    end

    private

    attr_reader :value
  end

  def Either(value)
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
    RFunk::Success(lambda.call)
  rescue => e
    RFunk::Failure(e)
  end

  def either_with_value(value)
    if value
      RFunk::Success(value)
    else
      RFunk::Failure(value)
    end
  end
end
