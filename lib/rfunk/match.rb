module RFunk
  module Match
    def match(option)
      pattern = RFunk::Match::Pattern.new
      yield(pattern)

      pattern_case = pattern.cases.select { |t| t.first == option.key || t.first == :_ }.first

      if pattern_case
        pattern_case.last.call(option.identity)
      else
        raise RFunk::Match::Error, "Could not match for option '#{option.key}'."
      end
    end
  end
end
