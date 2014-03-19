module RFunk
  module AttributeFunction
    def fun(method_name, &block)
      lambda = lambda { |*args|
        instance_exec(*args.unshift(Function.new), &block)
      }

      define_method method_name, &lambda
    end
  end
end
