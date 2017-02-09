describe RFunk::Either do
  context 'Some' do
    Given(:either) { RFunk.either(RFunk.option('YES')) }
    When(:result) { either.result }
    Then { expect(either).to eq(RFunk.success(RFunk.some('YES'))) }
    Then { expect(result).to eq(RFunk.some('YES')) }
    Then { expect(result.value).to eq('YES') }
  end

  context 'None' do
    Given(:either) { RFunk.either(RFunk.option(nil)) }
    When(:result) { either.result }
    Then { expect(either).to eq(RFunk.failure(RFunk.none)) }
  end

  context 'Lambda' do
    context 'Success' do
      Given(:either) { RFunk.either(-> { 'YES' }) }

      context 'gets value' do
        When(:result) { either.result }
        Then { expect(result).to eq(RFunk.some('YES')) }
        Then { expect(result.value).to eq('YES') }
      end

      context 'success?' do
        Then { expect(either.success?).to be_truthy }
        Then { expect(either.failure?).to be_falsey }
      end
    end

    context 'Success with or' do
      Given(:either) { RFunk.either(-> { 'success' }).or('failure') }

      context 'gets value' do
        When(:result) { either.result }
        Then { expect(result).to eq(RFunk.some('success')) }
        Then { expect(result.value).to eq('success') }
      end

      context 'success?' do
        Then { expect(either.success?).to be_truthy }
        Then { expect(either.failure?).to be_falsey }
      end
    end

    context 'Failure' do
      Given(:either) { RFunk.either(-> { 1 / 0 }) }

      context 'gets value' do
        When(:result) { either.result }
        Then { result.value.is_a?(ZeroDivisionError) }
      end

      context 'failure?' do
        Then { expect(either.success?).to be_falsey }
        Then { expect(either.failure?).to be_truthy }
      end
    end

    context 'Failure with or' do
      Given(:either) { RFunk.either(-> { 1 / 0 }).or('error') }

      context 'gets value' do
        When(:result) { either.result }
        Then { expect(result).to eq(RFunk.some('error')) }
        Then { expect(result.value).to eq('error') }
      end

      context 'failure?' do
        Then { expect(either.success?).to be_falsey }
        Then { expect(either.failure?).to be_truthy }
      end
    end
  end

  context 'Values' do
    context 'Success' do
      Given(:either) { RFunk.either(true) }

      context 'gets value' do
        When(:result) { either.result }
        Then { expect(result).to eq(RFunk.some(true)) }
        Then { expect(result.value).to eq(true) }
      end

      context 'success?' do
        Then { expect(either.success?).to be_truthy }
        Then { expect(either.failure?).to be_falsey }
      end
    end

    context 'Success with or' do
      Given(:either) { RFunk.either(true).or('failure') }

      context 'gets value' do
        When(:result) { either.result }
        Then { expect(result).to eq(RFunk.some(true)) }
        Then { expect(result.value).to eq(true) }
      end

      context 'success?' do
        Then { expect(either.success?).to be_truthy }
        Then { expect(either.failure?).to be_falsey }
      end
    end

    context 'Failure' do
      Given(:either) { RFunk.either(false) }

      context 'gets value' do
        When(:result) { either.result }
        Then { expect(result).to eq(RFunk.some(false)) }
        Then { expect(result.value).to eq(false) }
      end

      context 'failure?' do
        Then { expect(either.success?).to be_falsey }
        Then { expect(either.failure?).to be_truthy }
      end
    end

    context 'Failure with or' do
      Given(:either) { RFunk.either(false).or('error') }

      context 'gets value' do
        When(:result) { either.result }
        Then { expect(result).to eq(RFunk.some('error')) }
        Then { expect(result.value).to eq('error') }
      end

      context 'failure?' do
        Then { expect(either.success?).to be_falsey }
        Then { expect(either.failure?).to be_truthy }
      end
    end
  end
end
