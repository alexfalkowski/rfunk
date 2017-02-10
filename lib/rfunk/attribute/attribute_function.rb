module RFunk
  module AttributeFunction
    def fun(definition, &block)
      function_definition = function_definition(definition)
      lambda = ->(*args) { RFunk::Function.new(self, function_definition, &block).execute(*args) }

      define_method function_definition.value(0).value, &lambda
    end

    alias fn fun
    alias func fun
    alias defn fun

    private

    def function_definition(definition)
      case definition
      when Hash
        return_type = RFunk::TypeAnnotation.new(definition.values.first.to_s)
        RFunk.tuple(definition.keys.first, return_type)
      else
        RFunk.tuple(definition)
      end
    end
  end
end
