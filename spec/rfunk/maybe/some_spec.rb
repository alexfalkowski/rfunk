describe RFunk::Some do
  context 'Some' do
    context 'get a value' do
      When(:result) { RFunk.option(1) }
      Then { result.value == 1 }
    end

    context 'get a value with consistent interface' do
      When(:result) { RFunk.option(1) }
      Then { result.value('test') == 1 }
    end

    context 'methods on object' do
      context 'string' do
        When(:result) { RFunk.option('TEST') }
        Then { result.downcase == RFunk.some('test') }
      end

      context 'hash' do
        When(:result) { RFunk.option(a: 1) }
        Then { result[:a] == RFunk.some(1) }
      end
    end

    context 'or always returns the Some value' do
      context 'get a value' do
        When(:result) { RFunk.option(1).or(2) }
        Then { result.value == 1 }
      end
    end

    context 'already a Some' do
      When(:result) { RFunk.option(RFunk.some(1)) }
      Then { result == RFunk.some(1) }
    end

    context 'pipeline' do
      When(:result) { RFunk.option(a: 1).pipe(&:to_s).pipe { |s| "#{s}, hello" } }
      Then { result == RFunk.some('{:a=>1}, hello') }
    end
  end
end
