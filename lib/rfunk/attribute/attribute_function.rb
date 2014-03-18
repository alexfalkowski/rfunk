module RFunk
  module AttributeFunction
    def fun(method_name, &block)
      lambda = lambda { |*args|
        block.call(Function.new, *args)
      }

      define_method method_name, &lambda
    end
  end
end
