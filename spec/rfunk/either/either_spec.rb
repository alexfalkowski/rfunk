require 'spec_helper'

describe 'Either' do
  context 'Lambda' do
    context 'Success' do
      Given(:either) { Either(-> { 'YES' }) }

      context 'gets value' do
        When(:result) { either.result }
        Then { expect(result).to eq(Some('YES')) }
        Then { expect(result.value).to eq('YES') }
      end

      context 'success?' do
        Then { expect(either.success?).to be_true }
        Then { expect(either.failure?).to be_false }
      end
    end

    context 'Success with or' do
      Given(:either) { Either(-> { 'success' }).or('failure') }

      context 'gets value' do
        When(:result) { either.result }
        Then { expect(result).to eq(Some('success')) }
        Then { expect(result.value).to eq('success') }
      end

      context 'success?' do
        Then { expect(either.success?).to be_true }
        Then { expect(either.failure?).to be_false }
      end
    end

    context 'Failure' do
      Given(:either) { Either(-> { 1 / 0 }) }

      context 'gets value' do
        When(:result) { either.result }
        Then { result.value.is_a?(ZeroDivisionError) }
      end

      context 'failure?' do
        Then { expect(either.success?).to be_false }
        Then { expect(either.failure?).to be_true }
      end
    end

    context 'Failure with or' do
      Given(:either) { Either(-> { 1 / 0 }).or('error') }

      context 'gets value' do
        When(:result) { either.result }
        Then { expect(result).to eq(Some('error')) }
        Then { expect(result.value).to eq('error') }
      end

      context 'failure?' do
        Then { expect(either.success?).to be_false }
        Then { expect(either.failure?).to be_true }
      end
    end
  end

  context 'Values' do
    context 'Success' do
      Given(:either) { Either(true) }

      context 'gets value' do
        When(:result) { either.result }
        Then { expect(result).to eq(Some(true)) }
        Then { expect(result.value).to eq(true) }
      end

      context 'success?' do
        Then { expect(either.success?).to be_true }
        Then { expect(either.failure?).to be_false }
      end
    end

    context 'Success with or' do
      Given(:either) { Either(true).or('failure') }

      context 'gets value' do
        When(:result) { either.result }
        Then { expect(result).to eq(Some(true)) }
        Then { expect(result.value).to eq(true) }
      end

      context 'success?' do
        Then { expect(either.success?).to be_true }
        Then { expect(either.failure?).to be_false }
      end
    end

    context 'Failure' do
      Given(:either) { Either(false) }

      context 'gets value' do
        When(:result) { either.result }
        Then { expect(result).to eq(Some(false)) }
        Then { expect(result.value).to eq(false) }
      end

      context 'failure?' do
        Then { expect(either.success?).to be_false }
        Then { expect(either.failure?).to be_true }
      end
    end

    context 'Failure with or' do
      Given(:either) { Either(false).or('error') }

      context 'gets value' do
        When(:result) { either.result }
        Then { expect(result).to eq(Some('error')) }
        Then { expect(result.value).to eq('error') }
      end

      context 'failure?' do
        Then { expect(either.success?).to be_false }
        Then { expect(either.failure?).to be_true }
      end
    end
  end

end
