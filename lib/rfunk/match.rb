module RFunk
  module Match
    def match(option)
      pattern = RFunk::Match::Pattern.new
      yield(pattern)

      pattern.cases.each do |t|
        return t.last.call(option.identity) if t.first == option.key
      end

      raise RFunk::Match::Error, "Could not match for option '#{option.key}'."
    end
  end
end
