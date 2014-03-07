module RFunk
  class Success < Value
    def success?
      true
    end

    def failure?
      false
    end

    def or(_)
      self
    end
  end

  def Success(value)
    Success.new(value)
  end
end
