describe RFunk::Some do
  context 'Some' do
    context 'get a value' do
      When(:result) { Option(1) }
      Then { result.value == 1 }
    end

    context 'get a value with consistent interface' do
      When(:result) { Option(1) }
      Then { result.value('test') == 1 }
    end

    context 'methods on object' do
      context 'string' do
        When(:result) { Option('TEST') }
        Then { result.downcase == Some('test') }
      end

      context 'hash' do
        When(:result) { Option({ a: 1 }) }
        Then { result[:a] == Some(1) }
      end
    end

    context 'or always returns the Some value' do
      context 'get a value' do
        When(:result) { Option(1).or(2) }
        Then { result.value == 1 }
      end
    end

    context 'already a Some' do
      When(:result) { Option(Some(1)) }
      Then { result == Some(1) }
    end

    context 'pipeline' do
      When(:result) { Option({ a: 1 }).pipe { |h| h.to_s }.pipe { |s| "#{s}, hello" } }
      Then { result == Some('{:a=>1}, hello') }
    end
  end
end
