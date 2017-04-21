require_relative 'match_class'

describe RFunk::Match do
  context 'Some' do
    Given(:variable) { MatchClass.new }
    When(:result) { variable.something }
    Then { result == RFunk.some('YES IT WORKED') }
  end

  context 'None' do
    Given(:variable) { MatchClass.new }
    When(:result) { variable.nothing }
    Then { result == RFunk.some('IT IS A NONE') }
  end

  context 'None with error' do
    Given(:variable) { MatchClass.new }
    When(:result) { variable.nothing_with_error }
    Then { result == Failure(StandardError, 'ERROR') }
  end

  context 'Success' do
    Given(:variable) { MatchClass.new }
    When(:result) { variable.successful }
    Then { result == RFunk.some('YES IT WORKED') }
  end

  context 'Failure' do
    Given(:variable) { MatchClass.new }
    When(:result) { variable.failed }
    Then { result == RFunk.some('IT IS A NONE') }
  end

  context 'No match' do
    Given(:variable) { MatchClass.new }
    When(:result) { variable.no_match }
    Then { result == Failure(RFunk::Match::Error, "Could not match for option 'failure'.") }
  end
end
