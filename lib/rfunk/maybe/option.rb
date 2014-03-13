module RFunk
  class Option
    include Enumerable

    def each(&block)
      return enum_for(:enum) if block.nil?

      enum.each { |v| block.call(v) }
    end
  end

  def Option(value)
    if nothing?(value)
      None.instance
    else
      Some.new(value)
    end
  end

  private

  def nothing?(value)
    value.nil? || (value.respond_to?(:empty?) && value.empty?) || value.is_a?(None)
  end
end
