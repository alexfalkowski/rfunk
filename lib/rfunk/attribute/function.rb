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
        RFunk::Some(RFunk::Some(variables)[options])
      end
    end

    def assert(&_)
      return true if yield
      raise RFunk::AssertionError
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
      validate_parameter_types(*args)
      return_value = instance_exec(*args, &block)

      if body_block
        execute_body_block
      else
        validate_return_type(return_value)
        RFunk::Option(return_value)
      end
    end

    def method_missing(method, *arguments, &block)
      this.send(method, *arguments, &block)
    end

    def respond_to_missing?(method_name, include_private = false)
      this.respond_to_missing?(method_name, include_private)
    end

    private

    attr_reader :block, :pre_block, :post_block, :body_block, :function_definition
    attr_accessor :variables

    def execute_body_block
      execute_block pre_block, RFunk::PreConditionError

      RFunk::Option(instance_eval(&body_block)).tap do |body|
        execute_block post_block, RFunk::PostConditionError
        validate_return_type(body)
      end
    end

    def execute_block(block, error)
      return unless block
      instance_eval(&block).tap { |r| error_checking.raise_condition_error(error, r) }
    end

    def error_checking
      RFunk.lazy(-> { RFunk::ErrorChecking.new }).value
    end

    def validate_return_type(return_value)
      error_checking.raise_expected_return_type(function_name.value,
                                                return_value,
                                                type_annotation.return)
    end

    def validate_parameter_types(*args)
      values = args.zip(type_annotation.parameters)
      values.each_with_index do |v, i|
        tuple = RFunk::Tuple(*v)
        error_checking.raise_expected_parameter_type(i + 1, tuple.value(0), tuple.value(1))
      end
    end

    def function_name
      function_definition.value(0)
    end

    def type_annotation
      function_definition.value(1)
    end
  end
end
