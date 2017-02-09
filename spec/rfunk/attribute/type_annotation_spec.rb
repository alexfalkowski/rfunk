describe RFunk::TypeAnnotation do
  context 'Valid types' do
    context 'Single parameter' do
      When(:value) { RFunk::TypeAnnotation.new('Integer -> Integer') }
      Then { expect(value.parameters).to eq([Integer]) }
      Then { expect(value.return).to eq([Integer]) }
    end

    context 'Multiple parameters' do
      When(:value) { RFunk::TypeAnnotation.new('Integer, Integer -> Integer') }
      Then { expect(value.parameters).to eq([Integer, Integer]) }
      Then { expect(value.return).to eq([Integer]) }
    end

    context 'Return type' do
      When(:value) { RFunk::TypeAnnotation.new('Integer') }
      Then { expect(value.parameters).to eq([]) }
      Then { expect(value.return).to eq([Integer]) }
    end

    context 'Nil' do
      When(:value) { RFunk::TypeAnnotation.new(nil) }
      Then { expect(value.parameters).to eq([]) }
      Then { expect(value.return).to eq([]) }
    end

    context 'None' do
      When(:value) { RFunk::TypeAnnotation.new(RFunk.none) }
      Then { expect(value.parameters).to eq([]) }
      Then { expect(value.return).to eq([]) }
    end
  end

  context 'Invalid types' do
    context 'Incorrect parameters' do
      Given(:value) { RFunk::TypeAnnotation.new('Integer, ThisDoesNotExist -> Integer') }
      When(:result) { value.parameters }
      Then { result == Failure(NameError, 'uninitialized constant ThisDoesNotExist') }
    end
  end
end
