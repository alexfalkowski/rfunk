describe 'Coerce' do
  context 'Some' do
    context 'Integer' do
      When(:result) { RFunk.option(1) + RFunk.option(2) }
      Then { result == RFunk.some(3) }
    end

    context 'Float' do
      When(:result) { RFunk.option(1.0) + RFunk.option(2.3) }
      Then { result == RFunk.some(3.3) }
    end

    context 'String' do
      When(:result) { RFunk.option('hello ') + RFunk.option('world') }
      Then { result == RFunk.some('hello world') }
    end

    context 'Array' do
      When(:result) { RFunk.option(['a']) + RFunk.option(['b']) }
      Then { result == RFunk.some(%w(a b)) }
    end

    context 'Hash' do
      When(:result) { RFunk.option({ a: 1 }).merge(RFunk.option({ b: 1 })) }
      Then { result == RFunk.some({ a: 1, b: 1 }) }
    end
  end

  context 'None' do
    context 'Integer' do
      When(:result) { RFunk.option(1) + RFunk.none }
      Then { result == RFunk.some(1) }
    end

    context 'Float' do
      When(:result) { RFunk.option(1.7) + RFunk.none }
      Then { result == RFunk.some(1.7) }
    end

    context 'String' do
      When(:result) { RFunk.option('hello') + RFunk.none }
      Then { result == RFunk.some('hello') }
    end

    context 'Array' do
      When(:result) { RFunk.option(['a']) + RFunk.none }
      Then { result == RFunk.some(%w(a)) }
    end

    context 'Hash' do
      When(:result) { RFunk.option({ a: 1 }).merge(RFunk.none) }
      Then { result == RFunk.some({ a: 1 }) }
    end
  end
end
