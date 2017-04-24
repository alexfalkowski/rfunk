module RFunk
  class Option
    include Enumerable
    extend Forwardable

    class << self
      def inherited(subclass)
        @descendants ||= []
        @descendants << subclass
      end

      attr_reader :descendants
    end

    def_delegators :enum, :each
  end

  class << self
    def option(value)
      return value if RFunk::Option.descendants.map { |t| value.is_a?(t) }.any?
      RFunk::Option.descendants.find { |c| c.satisfies?(value) }.create(value)
    end
  end
end
