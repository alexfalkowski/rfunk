module RFunk
  class Maybe
    private_class_method :new

    def self.nothing?(value)
      value.nil? || (value.respond_to?(:empty?) && value.empty?) || value == Nothing
    end
  end
end
