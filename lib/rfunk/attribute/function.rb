module RFunk
  class Function
    def initialize
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

    private

    attr_accessor :variables
  end
end
