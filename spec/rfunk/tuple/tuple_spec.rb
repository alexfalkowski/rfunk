describe RFunk::Tuple do
  context 'Immutable' do
    Given(:tuple) { RFunk.tuple(1, 'test') }
    When(:result) { tuple.send(:values) << 'a' }
    Then { result == Failure(RuntimeError, /frozen/) }
  end

  context 'get a value' do
    context 'Some' do
      When(:result) { RFunk.tuple(1, 'test') }
      Then { result.value(0) == RFunk.some(1) }
      Then { result.value(1) == RFunk.some('test') }
    end

    context 'None' do
      context 'nil' do
        When(:result) { RFunk.tuple(nil) }
        Then { result.value(0) == RFunk.none() }
      end

      context 'None' do
        When(:result) { RFunk.tuple(RFunk.none()) }
        Then { result.value(0) == RFunk.none() }
      end

      context 'out of range' do
        When(:result) { RFunk.tuple('test') }
        Then { result.value(1) == RFunk.none() }
      end
    end
  end

  context 'set a value' do
    context 'Some' do
      Given(:value) { RFunk.tuple(1, 'test') }
      When(:result) { value.value(0, 'bob') }
      Then { result.value(0) == RFunk.some('bob') }
      Then { result.value(1) == RFunk.some('test') }
      Then { result.object_id != value.object_id }
    end

    context 'None' do
      context 'nil' do
        Given(:value) { RFunk.tuple(nil) }
        When(:result) { value.value(0, 'bob') }
        Then { result.value(0) == RFunk.some('bob') }
        Then { result.object_id != value.object_id }
      end

      context 'out of range' do
        Given(:value) { RFunk.tuple('test') }
        When(:result) { value.value(1, 'bob') }
        Then { result.value(0) == RFunk.some('test') }
        Then { result.value(1) == RFunk.some('bob') }
        Then { value.value(0) == RFunk.some('test') }
        Then { value.value(1) == RFunk.none() }
        Then { result.object_id != value.object_id }
      end
    end
  end
end
