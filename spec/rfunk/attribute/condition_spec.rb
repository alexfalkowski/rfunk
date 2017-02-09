require_relative 'condition_class'

describe RFunk::Attribute do
  context ConditionClass do
    Given(:value) { ConditionClass.new }

    context 'valid' do
      When(:result) { value.valid('test') }
      Then { result == RFunk.some('test') }
    end

    context 'pre-condition not met' do
      When(:result) { value.valid('nope') }
      Then { result == Failure(RFunk::PreConditionError, 'The condition was not met!') }
    end

    context 'post-condition not met' do
      When(:result) { value.invalid('test') }
      Then { result == Failure(RFunk::PostConditionError, 'The condition was not met!') }
    end

    context 'set attributes of class' do
      When(:result) { value.full_name('Alex', 'Falkowski') }
      Then { expect(result.first_name).to eq(RFunk.some('Alex')) }
      Then { expect(result.last_name).to eq(RFunk.some('Falkowski')) }
    end

    context 'asserting' do
      When(:result) { value.assert_argument('nope') }
      Then { result == Failure(RFunk::AssertionError) }
    end

    context 'Invalid return type' do
      When(:result) { value.invalid_return_type('test') }
      Then {
        result == Failure(TypeError, "Expected a type of 'Integer' for return 'invalid_return_type'")
      }
    end
  end
end
