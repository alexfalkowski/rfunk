module RFunk
  class Tuple
    def initialize(values)
      @values = values
    end

    def value(*args)
      index = args[0]

      if args.length == 1
        Option(values[index])
      else
        self.class.new(values.dup.tap { |v|
          v[index] = Option(args[1])
        })
      end
    end

    private

    attr_reader :values
  end

  def Tuple(*values)
    Tuple.new(values)
  end
end
