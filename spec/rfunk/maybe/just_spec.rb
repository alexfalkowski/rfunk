require 'spec_helper'

describe RFunk::Maybe do
  context 'Just' do
    context 'get a value' do
      When(:result) { Some(1) }
      Then { result.value == 1 }
    end

    context 'methods on object' do
      context 'string' do
        When(:result) { Some('TEST') }
        Then { result.downcase == Some('test') }
      end

      context 'hash' do
        When(:result) { Some({a: 1}) }
        Then { result[:a] == Some(1) }
      end
    end

    context 'or always returns the Some value' do
      context 'get a value' do
        When(:result) { Some(1).or(2) }
        Then { result.value == 1 }
      end
    end
  end
end
