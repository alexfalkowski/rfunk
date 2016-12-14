module RFunk
  class Option
    include Enumerable

    def each(&block)
      return enum_for(:enum) if block.nil?

      enum.each { |v| yield v }
    end
  end

  def Option(value)
    if [RFunk::Some, RFunk::None].map { |t| value.is_a?(t) }.any?
      value
    elsif nothing?(value)
      RFunk::None.instance
    else
      RFunk::Some.new(value)
    end
  end

  private

  def nothing?(value)
    value.nil? || (value.respond_to?(:empty?) && value.empty?) || value == RFunk::None.instance
  end
end
