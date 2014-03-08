module RFunk
  class Failure < Value
    def success?
      false
    end

    def failure?
      true
    end

    def or(value)
      Failure(value)
    end
  end

  def Failure(value)
    Failure.new(value)
  end
end
