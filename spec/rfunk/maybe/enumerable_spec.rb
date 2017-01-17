describe 'Enumerable' do
  context 'Some' do
    context 'flat_map' do
      Given(:values) { [Option(1), Option(2)] }
      When(:result) { values.flat_map { |i| i.to_a } }
      Then { expect(result).to eq([1, 2]) }
    end

    context 'sort' do
      Given(:values) { [Option(2), Option(1)] }
      When(:result) { values.sort }
      Then { expect(result).to eq([Option(1), Option(2)]) }
    end

    context 'array' do
      Given(:values) { Option([1, 2, 3]) }
      When(:result) { values.map { |i| i * 2 } }
      Then { expect(result).to eq(Some([2, 4, 6])) }
    end
  end

  context 'None' do
    context 'flat_map' do
      Given(:values) { [None(), None()] }
      When(:result) { values.flat_map { |i| i.to_a } }
      Then { expect(result).to eq([]) }
    end

    context 'sort' do
      Given(:values) { [None(), None()] }
      When(:result) { values.sort }
      Then { expect(result).to eq([None(), None()]) }
    end

  end

  context 'Mixed' do
    context 'flat_map' do
      Given(:values) { [Some(1), None()] }
      When(:result) { values.flat_map { |i| i.to_a } }
      Then { expect(result).to eq([1]) }
    end
  end
end
