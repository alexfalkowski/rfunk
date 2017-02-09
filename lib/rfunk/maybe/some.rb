module RFunk
  class Some < Option
    extend Forwardable

    def initialize(value)
      @value = value
    end

    def value(_ = RFunk.none)
      @value
    end

    def or(_)
      self
    end

    def pipe(&block)
      return self if block.nil?
      RFunk.option(yield value)
    end

    def method_missing(method, *arguments, &block)
      RFunk.option(value.send(method, *arguments, &block))
    end

    def ==(other)
      return false unless self.class == other.class
      value == RFunk.option(other).value
    end

    def <=>(other)
      value <=> other.value
    end

    def coerce(other)
      [other, value]
    end

    [:to_str, :to_ary, :to_hash].each { |k| define_method(k) { value } }

    def_delegators :@value, :to_s, :inspect, :respond_to?, :class

    protected

    def enum
      enumerable? ? value : [value]
    end

    private

    def enumerable?
      value.is_a?(Enumerable)
    end
  end

  class << self
    def some(value)
      RFunk.option(value)
    end
  end
end
