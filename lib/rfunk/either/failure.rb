module RFunk
  class Failure < Either
    def success?
      false
    end

    def failure?
      true
    end

    def or(value)
      RFunk::Failure(value)
    end
  end

  def Failure(value)
    RFunk::Failure.new(value)
  end
end
