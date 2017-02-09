module RFunk
  class Failure < Either
    def success?
      false
    end

    def failure?
      true
    end

    def or(value)
      RFunk.failure(value)
    end
  end

  class << self
    def failure(value)
      RFunk::Failure.new(value)
    end
  end
end
