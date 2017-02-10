require_relative 'match_class'

describe RFunk::Match do
  context 'Some' do
    Given(:variable) { MatchClass.new }
    When(:result) { variable.something }
    Then { expect(result).to eq(RFunk.some('YES IT WORKED')) }
  end

  context 'None' do
    Given(:variable) { MatchClass.new }
    When(:result) { variable.nothing }
    Then { expect(result).to eq(RFunk.some('IT IS A NONE')) }
  end

  context 'None with error' do
    Given(:variable) { MatchClass.new }
    When(:result) { variable.nothing_with_error }
    Then { result == Failure(StandardError, 'ERROR') }
  end

  context 'Success' do
    Given(:variable) { MatchClass.new }
    When(:result) { variable.successful }
    Then { expect(result).to eq(RFunk.some('YES IT WORKED')) }
  end

  context 'Failure' do
    Given(:variable) { MatchClass.new }
    When(:result) { variable.failed }
    Then { expect(result).to eq(RFunk.some('IT IS A NONE')) }
  end
end
