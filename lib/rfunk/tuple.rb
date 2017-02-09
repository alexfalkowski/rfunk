module RFunk
  class Tuple
    def initialize(values)
      @values = values
      deep_freeze
    end

    def value(*args)
      index = args[0]

      if args.length == 1
        RFunk.option(values[index])
      else
        self.class.new(values.dup.tap { |v| v[index] = RFunk.option(args[1]) })
      end
    end

    private

    attr_reader :values
  end

  class << self
    def tuple(*values)
      RFunk::Tuple.new(values)
    end
  end
end
