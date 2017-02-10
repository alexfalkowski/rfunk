require_relative 'value_class'

describe RFunk::AttributeFunction do
  context 'Declaring' do
    context 'Call once' do
      Given(:variable) { ValueClass.new }
      When(:result) { variable.declare_valid }
      Then { expect(result).to eq(RFunk.some('Hello')) }
    end

    context 'Call twice' do
      Given(:variable) { ValueClass.new }
      When(:result) { variable.declare_valid; variable.declare_valid }
      Then { expect(result).to eq(RFunk.some('Hello')) }
    end

    context 'Invalid return type' do
      Given(:variable) { ValueClass.new }
      When(:result) { variable.invalid_return_type }
      Then {
        result == Failure(TypeError, "Expected a type of 'Integer' for return 'invalid_return_type'")
      }
    end
  end

  context 'set attributes of class' do
    Given(:variable) { ValueClass.new }
    When(:result) { variable.full_name('Alex', 'Falkowski') }
    Then { expect(result.first_name).to eq(RFunk.some('Alex')) }
    Then { expect(result.last_name).to eq(RFunk.some('Falkowski')) }
  end

  context 'With parameters' do
    context 'Valid' do
      Given(:variable) { ValueClass.new }
      When(:result) { variable.parameter('Parameters') }
      Then { expect(result).to eq(RFunk.some('Parameters')) }
    end

    context 'Invalid' do
      Given(:variable) { ValueClass.new }
      When(:result) { variable.parameter(1) }
      Then { result == Failure(TypeError, "Expected a type of 'String' for parameter '1'") }
    end
  end

  context 'Declaring multiple variables' do
    Given(:variable) { ValueClass.new }
    When(:result) { variable.declare_multiple }
    Then { expect(result).to eq(RFunk.some('Multiple')) }
  end

  context 'Undefined variable' do
    Given(:variable) { ValueClass.new }
    When(:result) { variable.undefined }
    Then { expect(result).to eq(RFunk.none) }
  end

  context 'Override an existing variable' do
    Given(:variable) { ValueClass.new }
    When(:result) { variable.override_existing }
    Then {
      result == Failure(RFunk::ImmutableError, "Could not rebind a value '[:hello]', because they are immutable.")
    }
  end

  context 'Thread safe' do
    Given(:variable) { ValueClass.new }
    When(:threads) { 20.times.map { |i| Thread.new { variable.full_name("Alex#{i}", 'Falkowski') } } }
    Then { threads.each { |t| t.join } }
  end
end
