describe RFunk::TypeAnnotation do
  context 'Valid types' do
    context 'Single parameter' do
      When(:value) { RFunk::TypeAnnotation.new('Integer -> Integer') }
      Then { value.parameters == [Integer] }
      Then { value.return == [Integer] }
    end

    context 'Multiple parameters' do
      When(:value) { RFunk::TypeAnnotation.new('Integer, Integer -> Integer') }
      Then { value.parameters == [Integer, Integer] }
      Then { value.return == [Integer] }
    end

    context 'Return type' do
      When(:value) { RFunk::TypeAnnotation.new('Integer') }
      Then { value.parameters == [] }
      Then { value.return == [Integer] }
    end

    context 'Nil' do
      When(:value) { RFunk::TypeAnnotation.new(nil) }
      Then { value.parameters == [] }
      Then { value.return == [] }
    end

    context 'None' do
      When(:value) { RFunk::TypeAnnotation.new(RFunk.none) }
      Then { value.parameters == [] }
      Then { value.return == [] }
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
