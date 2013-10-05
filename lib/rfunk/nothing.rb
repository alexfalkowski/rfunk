module RFunk
  class Nothing < Maybe
    class << self
      def value(default = nil)
        Some(default)
      end

      def or(other)
        Some(other)
      end

      def method_missing(method, *arguments, &block)
        self
      end
    end
  end
end
