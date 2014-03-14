module RFunk
  class Failure < Either
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
