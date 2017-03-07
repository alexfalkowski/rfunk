describe RFunk::Either do
  context 'Some' do
    Given(:either) { RFunk.either(RFunk.option('YES')) }
    When(:result) { either.result }
    Then { either == RFunk.success(RFunk.some('YES')) }
    Then { result == RFunk.some('YES') }
    Then { result.value == 'YES' }
  end

  context 'None' do
    Given(:either) { RFunk.either(RFunk.option(nil)) }
    When(:result) { either.result }
    Then { either == RFunk.failure(RFunk.none) }
  end

  context 'Lambda' do
    context 'Success' do
      Given(:either) { RFunk.either(-> { 'YES' }) }

      context 'gets value' do
        When(:result) { either.result }
        Then { result == RFunk.some('YES') }
        Then { result.value == 'YES' }
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
        Then { result == RFunk.some('success') }
        Then { result.value == 'success' }
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
        Then { result == RFunk.some('error') }
        Then { result.value == 'error' }
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
        Then { result == RFunk.some(true) }
        Then { result.value == true }
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
        Then { result == RFunk.some(true) }
        Then { result.value == true }
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
        Then { result == RFunk.some(false) }
        Then { result.value == false }
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
        Then { result == RFunk.some('error') }
        Then { result.value == 'error' }
      end

      context 'failure?' do
        Then { expect(either.success?).to be_falsey }
        Then { expect(either.failure?).to be_truthy }
      end
    end
  end
end
