describe 'Enumerable' do
  context 'Some' do
    context 'flat_map' do
      Given(:values) { [RFunk.option(1), RFunk.option(2)] }
      When(:result) { values.flat_map(&:to_a) }
      Then { result == [1, 2] }
    end

    context 'sort' do
      Given(:values) { [RFunk.option(2), RFunk.option(1)] }
      When(:result) { values.sort }
      Then { result == [RFunk.option(1), RFunk.option(2)] }
    end

    context 'array' do
      Given(:values) { RFunk.option([1, 2, 3]) }
      When(:result) { values.map { |i| i * 2 } }
      Then { result == [2, 4, 6] }
    end
  end

  context 'None' do
    context 'flat_map' do
      Given(:values) { [RFunk.none, RFunk.none] }
      When(:result) { values.flat_map(&:to_a) }
      Then { result == [] }
    end

    context 'sort' do
      Given(:values) { [RFunk.none, RFunk.none] }
      When(:result) { values.sort }
      Then { result == [RFunk.none, RFunk.none] }
    end

  end

  context 'Mixed' do
    context 'flat_map' do
      Given(:values) { [RFunk.some(1), RFunk.none] }
      When(:result) { values.flat_map(&:to_a) }
      Then { result == [1] }
    end
  end
end
