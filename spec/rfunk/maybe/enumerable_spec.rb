describe 'Enumerable' do
  context 'Some' do
    context 'flat_map' do
      Given(:values) { [RFunk.option(1), RFunk.option(2)] }
      When(:result) { values.flat_map { |i| i.to_a } }
      Then { expect(result).to eq([1, 2]) }
    end

    context 'sort' do
      Given(:values) { [RFunk.option(2), RFunk.option(1)] }
      When(:result) { values.sort }
      Then { expect(result).to eq([RFunk.option(1), RFunk.option(2)]) }
    end

    context 'array' do
      Given(:values) { RFunk.option([1, 2, 3]) }
      When(:result) { values.map { |i| i * 2 } }
      Then { expect(result).to eq(RFunk.some([2, 4, 6])) }
    end
  end

  context 'None' do
    context 'flat_map' do
      Given(:values) { [RFunk.none, RFunk.none] }
      When(:result) { values.flat_map { |i| i.to_a } }
      Then { expect(result).to eq([]) }
    end

    context 'sort' do
      Given(:values) { [RFunk.none, RFunk.none] }
      When(:result) { values.sort }
      Then { expect(result).to eq([RFunk.none, RFunk.none]) }
    end

  end

  context 'Mixed' do
    context 'flat_map' do
      Given(:values) { [RFunk.some(1), RFunk.none] }
      When(:result) { values.flat_map { |i| i.to_a } }
      Then { expect(result).to eq([1]) }
    end
  end
end
