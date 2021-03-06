module RFunk
  class Some < Option
    class << self
      def create(value)
        new(value)
      end

      def satisfies?(value)
        !value.nil?
      end
    end

    attr_reader :value

    def initialize(value)
      @value = value
    end

    alias identity value

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
      value == other.value
    end

    def <=>(other)
      value <=> other.value
    end

    def coerce(other)
      [other, value]
    end

    %i[to_str to_ary to_hash].each { |k| define_method(k) { value } }

    def key
      :some
    end

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
