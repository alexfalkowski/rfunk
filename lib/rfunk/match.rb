module RFunk
  module Match
    def match(option)
      pattern = RFunk::Match::Pattern.new
      yield(pattern)

      pattern_case = pattern.cases.find { |t| t.first == option.key || t.first == :_ }

      return pattern_case.last.call(option.identity) if pattern_case

      raise RFunk::Match::Error, "Could not match for option '#{option.key}'."
    end
  end
end
