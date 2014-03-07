require 'spec_helper'

describe RFunk::Lazy do
  context 'Lazy' do
    let(:array) { [] }

    context 'Some' do
      Given(:lazy) { Lazy(-> { array << 'one' }) }

      context 'get a value' do
        When(:result) { lazy.value }
        Then { expect(array).to eq(['one']) }
        Then { expect(result).to eq(Some(['one'])) }
      end

      context 'get a value once' do
        When { lazy.value }
        When(:result) { lazy.value }
        Then { expect(array).to eq(['one']) }
        Then { expect(result).to eq(Some(['one'])) }
      end
    end

    context 'None' do
      Given(:lazy) { Lazy(-> { nil }) }
      When(:result) { lazy.value }
      Then { expect(result).to eq(None()) }
    end

    context 'does not get a value' do
      Then { expect(array).to be_empty }
    end
  end
end
