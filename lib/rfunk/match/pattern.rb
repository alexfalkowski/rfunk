module RFunk
  module Match
    class Pattern
      attr_reader :cases

      def initialize
        @cases = []
      end

      def with(type, func)
        cases << [type, func]
        RFunk.none
      end
    end
  end
end
