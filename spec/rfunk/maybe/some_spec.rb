require 'spec_helper'

describe RFunk::Some do
  context 'Some' do
    context 'get a value' do
      When(:result) { Option(1) }
      Then { result.value == 1 }
    end

    context 'coerce a value' do
      context 'Integer' do
        When(:result) { Option(1) + Option(2) }
        Then { result == Some(3) }
      end

      context 'String' do
        When(:result) { Option('hello ') + Option('world') }
        Then { result == Some('hello world') }
      end

      context 'Array' do
        When(:result) { Option(['a']) + Option(['b']) }
        Then { result == Some(%w(a b)) }
      end
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
      Then { expect(result).to eq(Some(1)) }
    end
  end
end
