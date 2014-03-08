module RFunk
  def Either(value)
    if lambda?(value)
      either_with_lambda(value)
    else
      either_with_value(value)
    end
  end

  private

  def lambda?(value)
    value.respond_to?(:lambda?) and value.lambda?
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
