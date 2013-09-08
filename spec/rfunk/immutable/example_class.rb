class ExampleClass
  extend RFunk::Immutable

  attr_reader :value

  def initialize(value)
    @value = value
  end
end
