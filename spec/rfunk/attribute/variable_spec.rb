require 'spec_helper'
require_relative 'variable_class'

describe RFunk::Variable do
  context 'Declaring a variable' do
    Given(:variable) { VariableClass.new }
    When(:result) { variable.declare_valid }
    Then { expect(result).to eq(Some('Hello')) }
  end

  context 'Declaring multiple variables' do
    Given(:variable) { VariableClass.new }
    When(:result) { variable.declare_multiple }
    Then { expect(result).to eq(Some('Multiple')) }
  end

  context 'Override an existing variable' do
    Given(:variable) { VariableClass.new }
    When(:result) { variable.override_existing }
    Then { result == Failure(ImmutableError, "Could not set variables '[:hello]', because variables are immutable.") }
  end
end
