module RFunk
  class Function
    attr_reader :this

    def initialize(this, &block)
      @this = this
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
      result = instance_exec(*args, &block)

      if body_block
        if pre_block
          instance_eval(&pre_block).tap { |r|
            error_checking.raise_condition_error(PreConditionError, r)
          }
        end

        Option(instance_eval(&body_block)).tap {
          if post_block
            instance_eval(&post_block).tap { |r|
              error_checking.raise_condition_error(PostConditionError, r)
            }
          end
        }
      else
        Option(result)
      end
    end

    def method_missing(method, *arguments, &block)
      this.send(method, *arguments, &block)
    end

    private

    attr_reader :block, :pre_block, :post_block, :body_block
    attr_accessor :variables

    def error_checking
      @error_checking ||= ErrorChecking.new
    end
  end
end
