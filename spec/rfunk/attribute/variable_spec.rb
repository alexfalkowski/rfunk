require 'spec_helper'
require_relative 'variable_class'

describe RFunk::AttributeFunction do
  context 'Declaring' do
    context 'Call once' do
      Given(:variable) { VariableClass.new }
      When(:result) { variable.declare_valid }
      Then { expect(result).to eq(Some('Hello')) }
    end

    context 'Call twice' do
      Given(:variable) { VariableClass.new }
      When(:result) { variable.declare_valid; variable.declare_valid }
      Then { expect(result).to eq(Some('Hello')) }
    end

    context 'Invalid return type' do
      Given(:variable) { VariableClass.new }
      When(:result) { variable.invalid_return_type }
      Then {
        result == Failure(TypeError, "Expected a type of 'Integer' for return 'invalid_return_type'")
      }
    end
  end

  context 'set attributes of class' do
    Given(:variable) { VariableClass.new }
    When(:result) { variable.full_name('Alex', 'Falkowski') }
    Then { expect(result.first_name).to eq(Some('Alex')) }
    Then { expect(result.last_name).to eq(Some('Falkowski')) }
  end

  context 'With parameters' do
    context 'Valid' do
      Given(:variable) { VariableClass.new }
      When(:result) { variable.parameter('Parameters') }
      Then { expect(result).to eq(Some('Parameters')) }
    end

    context 'Invalid' do
      Given(:variable) { VariableClass.new }
      When(:result) { variable.parameter(1) }
      Then { result == Failure(TypeError, "Expected a type of 'String' for parameter '1'") }
    end
  end

  context 'Declaring multiple variables' do
    Given(:variable) { VariableClass.new }
    When(:result) { variable.declare_multiple }
    Then { expect(result).to eq(Some('Multiple')) }
  end

  context 'Undefined variable' do
    Given(:variable) { VariableClass.new }
    When(:result) { variable.undefined }
    Then { expect(result).to eq(None()) }
  end

  context 'Override an existing variable' do
    Given(:variable) { VariableClass.new }
    When(:result) { variable.override_existing }
    Then {
      result == Failure(ImmutableError, "Could not set variables '[:hello]', because variables are immutable.")
    }
  end

  context 'Thread safe' do
    Given(:variable) { VariableClass.new }
    When(:threads) { 20.times.map { |i| Thread.new { variable.full_name("Alex#{i}", 'Falkowski') } } }
    Then { threads.each { |t| t.join } }
  end
end
