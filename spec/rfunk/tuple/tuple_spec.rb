describe RFunk::Tuple do
  context 'Immutable' do
    Given(:tuple) { Tuple(1, 'test') }
    When(:result) { tuple.send(:values) << 'a' }
    Then { result == Failure(RuntimeError, /frozen/) }
  end

  context 'get a value' do
    context 'Some' do
      When(:result) { Tuple(1, 'test') }
      Then { expect(result.value(0)).to eq(Some(1)) }
      Then { expect(result.value(1)).to eq(Some('test')) }
    end

    context 'None' do
      context 'nil' do
        When(:result) { Tuple(nil) }
        Then { expect(result.value(0)).to eq(None()) }
      end

      context 'None' do
        When(:result) { Tuple(None()) }
        Then { expect(result.value(0)).to eq(None()) }
      end

      context 'out of range' do
        When(:result) { Tuple('test') }
        Then { expect(result.value(1)).to eq(None()) }
      end
    end
  end

  context 'set a value' do
    context 'Some' do
      Given(:value) { Tuple(1, 'test') }
      When(:result) { value.value(0, 'bob') }
      Then { expect(result.value(0)).to eq(Some('bob')) }
      Then { expect(result.value(1)).to eq(Some('test')) }
      Then { expect(result.object_id).to_not eq(value.object_id) }
    end

    context 'None' do
      context 'nil' do
        Given(:value) { Tuple(nil) }
        When(:result) { value.value(0, 'bob') }
        Then { expect(result.value(0)).to eq(Some('bob')) }
        Then { expect(result.object_id).to_not eq(value.object_id) }
      end

      context 'out of range' do
        Given(:value) { Tuple('test') }
        When(:result) { value.value(1, 'bob') }
        Then { expect(result.value(0)).to eq(Some('test')) }
        Then { expect(result.value(1)).to eq(Some('bob')) }
        Then { expect(value.value(0)).to eq(Some('test')) }
        Then { expect(value.value(1)).to eq(None()) }
        Then { expect(result.object_id).to_not eq(value.object_id) }
      end
    end
  end
end
