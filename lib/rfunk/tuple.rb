module RFunk
  class Tuple
    def initialize(values)
      @values = values
      deep_freeze
    end

    def value(*args)
      index = args[0]

      if args.length == 1
        RFunk::Option(values[index])
      else
        self.class.new(values.dup.tap { |v| v[index] = RFunk::Option(args[1]) })
      end
    end

    private

    attr_reader :values
  end

  def Tuple(*values)
    RFunk::Tuple.new(values)
  end
end
