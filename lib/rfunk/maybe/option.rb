module RFunk
  class Option
    include Enumerable

    class << self
      def inherited(subclass)
        @descendants ||= []
        @descendants << subclass
      end

      attr_reader :descendants
    end

    def each
      enum.each { |v| yield v }
    end
  end

  class << self
    def option(value)
      return value if RFunk::Option.descendants.map { |t| value.is_a?(t) }.any?
      RFunk::Option.descendants.find { |c| c.satisfies?(value) }.create(value)
    end
  end
end
