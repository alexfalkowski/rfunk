require 'spec_helper'

describe 'Coerce' do
  context 'Some' do
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

  context 'None' do
    context 'Integer' do
      When(:result) { Option(1) + None() }
      Then { result == Some(1) }
    end

    context 'String' do
      When(:result) { Option('hello') + None() }
      Then { result == Some('hello') }
    end

    context 'Array' do
      When(:result) { Option(['a']) + None() }
      Then { result == Some(%w(a)) }
    end
  end
end
