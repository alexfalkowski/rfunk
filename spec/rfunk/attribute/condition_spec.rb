require 'spec_helper'
require_relative 'condition_class'

describe RFunk::Attribute do
  context ConditionClass do
    Given(:value) { ConditionClass.new }

    context 'valid' do
      When(:result) { value.valid('test') }
      Then { result == Some('test') }
    end

    context 'pre-condition not met' do
      When(:result) { value.valid('nope') }
      Then { result == Failure(PreConditionError, 'The condition was not met!') }
    end

    context 'post-condition not met' do
      When(:result) { value.invalid('test') }
      Then { result == Failure(PostConditionError, 'The condition was not met!') }
    end

    context 'set attributes of class' do
      When(:result) { value.full_name('Alex', 'Falkowski') }
      Then { expect(result.first_name).to eq(Some('Alex')) }
      Then { expect(result.last_name).to eq(Some('Falkowski')) }
    end

    context 'asserting' do
      When(:result) { value.assert_argument('nope') }
      Then { result == Failure(AssertionError) }
    end
  end
end
