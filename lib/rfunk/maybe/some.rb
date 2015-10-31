module RFunk
  class Some < Option
    extend Forwardable

    def initialize(value)
      @value = value
    end

    def value(_ = RFunk::None())
      @value
    end

    def or(_)
      self
    end

    def method_missing(method, *arguments, &block)
      RFunk::Option(value.send(method, *arguments, &block))
    end

    def ==(other)
      return false unless self.class == other.class

      value == other.value
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
      [value]
    end
  end

  def Some(value)
    RFunk::Option(value)
  end
end
