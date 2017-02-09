describe RFunk::Tuple do
  context 'Immutable' do
    Given(:tuple) { RFunk.tuple(1, 'test') }
    When(:result) { tuple.send(:values) << 'a' }
    Then { result == Failure(RuntimeError, /frozen/) }
  end

  context 'get a value' do
    context 'Some' do
      When(:result) { RFunk.tuple(1, 'test') }
      Then { expect(result.value(0)).to eq(RFunk.some(1)) }
      Then { expect(result.value(1)).to eq(RFunk.some('test')) }
    end

    context 'None' do
      context 'nil' do
        When(:result) { RFunk.tuple(nil) }
        Then { expect(result.value(0)).to eq(RFunk.none()) }
      end

      context 'None' do
        When(:result) { RFunk.tuple(RFunk.none()) }
        Then { expect(result.value(0)).to eq(RFunk.none()) }
      end

      context 'out of range' do
        When(:result) { RFunk.tuple('test') }
        Then { expect(result.value(1)).to eq(RFunk.none()) }
      end
    end
  end

  context 'set a value' do
    context 'Some' do
      Given(:value) { RFunk.tuple(1, 'test') }
      When(:result) { value.value(0, 'bob') }
      Then { expect(result.value(0)).to eq(RFunk.some('bob')) }
      Then { expect(result.value(1)).to eq(RFunk.some('test')) }
      Then { expect(result.object_id).to_not eq(value.object_id) }
    end

    context 'None' do
      context 'nil' do
        Given(:value) { RFunk.tuple(nil) }
        When(:result) { value.value(0, 'bob') }
        Then { expect(result.value(0)).to eq(RFunk.some('bob')) }
        Then { expect(result.object_id).to_not eq(value.object_id) }
      end

      context 'out of range' do
        Given(:value) { RFunk.tuple('test') }
        When(:result) { value.value(1, 'bob') }
        Then { expect(result.value(0)).to eq(RFunk.some('test')) }
        Then { expect(result.value(1)).to eq(RFunk.some('bob')) }
        Then { expect(value.value(0)).to eq(RFunk.some('test')) }
        Then { expect(value.value(1)).to eq(RFunk.none()) }
        Then { expect(result.object_id).to_not eq(value.object_id) }
      end
    end
  end
end
