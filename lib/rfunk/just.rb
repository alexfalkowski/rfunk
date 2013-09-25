module RFunk
  class Just < Maybe
    public_class_method :new

    attr_reader :value
    alias_method :fetch, :value

    def initialize(value)
      @value = value
    end

    def method_missing(method, *arguments, &block)
      Some(@value.__send__(method, *arguments, &block))
    end

    def ==(just)
      just.value == value
    end
  end
end
