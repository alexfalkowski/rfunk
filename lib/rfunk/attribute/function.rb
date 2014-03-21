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
          ErrorChecking.new.raise_immutable(options, variables)
          self.variables = variables.merge(options)
        end
      else
        Some(Some(variables)[options])
      end
    end

    def execute(*args)
      instance_exec(*args, &block)
    end

    def method_missing(method, *arguments, &block)
      this.send(method, *arguments, &block)
    end

    private

    attr_accessor :variables, :block
  end
end
