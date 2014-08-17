module RFunk
  module AttributeFunction
    def fun(definition, &block)
      method_definition = method_definition(definition)

      lambda = lambda { |*args|
        Function.new(self, method_definition, &block).execute(*args)
      }

      define_method method_definition.value(0).value, &lambda
    end

    [:fn, :func, :defn].each { |m| alias_method m, :fun }

    private

    def method_definition(definition)
      case definition
      when Hash
        Tuple(definition.keys.first, definition.values.first)
      else
        Tuple(definition, None())
      end
    end
  end
end
