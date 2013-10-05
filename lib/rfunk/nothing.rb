module RFunk
  class Nothing < Maybe
    class << self
      def value(default = nil)
        if Maybe.nothing?(default)
          self
        else
          Some(default)
        end
      end

      def or(other)
        value(other)
      end

      def method_missing(method, *arguments, &block)
        self
      end
    end
  end
end
