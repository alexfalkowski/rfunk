module RFunk
  module AttributeFunction
    def fun(definition, &block)
      function_definition = function_definition(definition)
      lambda = -> (*args) { Function.new(self, function_definition, &block).execute(*args) }

      define_method function_definition.value(0).value, &lambda
    end

    [:fn, :func, :defn].each { |m| alias_method m, :fun }

    private

    def function_definition(definition)
      case definition
      when Hash
        return_type = TypeAnnotation.new(definition.values.first.to_s)
        Tuple(definition.keys.first, return_type)
      else
        Tuple(definition)
      end
    end
  end
end
