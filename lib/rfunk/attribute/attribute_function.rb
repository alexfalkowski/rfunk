module RFunk
  module AttributeFunction
    def fun(method_name, &block)
      lambda = lambda { |*args|
        Function.new(self, &block).execute(*args)
      }

      define_method method_name, &lambda
    end

    [:func, :defn].each { |m| alias_method m, :fun }
  end
end
