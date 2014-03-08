module RFunk
  class None
    include Singleton

    def value(default = nil)
      Option(default)
    end

    def or(other)
      Option(other)
    end

    def method_missing(method, *arguments, &block)
      self
    end
  end

  def None(value = nil)
    Option(value)
  end
end
