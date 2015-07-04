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
        Then { expect(lazy.created?).to be_truthy }
      end

      context 'get a value once' do
        When { lazy.value }
        When(:result) { lazy.value }
        Then { expect(array).to eq(['one']) }
        Then { expect(result).to eq(Some(['one'])) }
        Then { expect(lazy.created?).to be_truthy }
      end
    end

    context 'None' do
      Given(:lazy) { Lazy(-> { nil }) }
      When(:result) { lazy.value }
      Then { expect(result).to eq(None()) }
      Then { expect(lazy.created?).to be_truthy }
    end

    context 'does not get a value' do
      Given(:lazy) { Lazy(-> { array << 'one' }) }
      Then { expect(array).to be_empty }
      Then { expect(lazy.created?).to be_falsey }
    end
  end
end
