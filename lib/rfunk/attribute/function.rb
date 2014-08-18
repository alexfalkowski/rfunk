module RFunk
  class Function
    attr_reader :this

    def initialize(this, function_definition, &block)
      @this = this
      @function_definition = function_definition
      @block = block
      @variables = {}
    end

    def var(options)
      if options.is_a?(Hash)
        if variables.empty?
          self.variables = options
        else
          error_checking.raise_immutable(options, variables)
          self.variables = variables.merge(options)
        end
      else
        Some(Some(variables)[options])
      end
    end

    def assert(&_)
      if yield
        true
      else
        raise AssertionError
      end
    end

    def pre(&block)
      @pre_block = block
    end

    def post(&block)
      @post_block = block
    end

    def body(&block)
      @body_block = block
    end

    def execute(*args)
      validate_parameter_types *args
      return_value = instance_exec(*args, &block)

      if body_block
        if pre_block
          instance_eval(&pre_block).tap { |r|
            error_checking.raise_condition_error(PreConditionError, r)
          }
        end

        Option(instance_eval(&body_block)).tap { |body|
          if post_block
            instance_eval(&post_block).tap { |post|
              error_checking.raise_condition_error(PostConditionError, post)
            }
          end

          validate_return_type(body)
        }
      else
        validate_return_type(return_value)
        Option(return_value)
      end
    end

    def method_missing(method, *arguments, &block)
      this.send(method, *arguments, &block)
    end

    private

    attr_reader :block, :pre_block, :post_block, :body_block, :function_definition
    attr_accessor :variables

    def error_checking
      Lazy(-> { ErrorChecking.new }).value
    end

    def validate_return_type(return_value)
      error_checking.raise_expected_return_type(function_name.value,
                                                return_value,
                                                type_annotation.return)
    end

    def validate_parameter_types(*args)
      values = args.zip(type_annotation.parameters)
      values.each_with_index { |v, i|
        tuple = Tuple(*v)
        error_checking.raise_expected_parameter_type(i + 1, tuple.value(0), tuple.value(1))
      }
    end

    def function_name
      function_definition.value(0)
    end

    def type_annotation
      function_definition.value(1)
    end
  end
end
