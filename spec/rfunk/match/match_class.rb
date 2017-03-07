class MatchClass
  include RFunk::Attribute
  include RFunk::Match

  fun :something do
    match(RFunk.some('YES')) do |p|
      p.with :some, ->(v) { "#{v} IT WORKED" }
    end
  end

  fun :nothing do
    match(RFunk.none) do |p|
      p.with :none, ->(_) { 'IT IS A NONE' }
    end
  end

  fun :nothing_with_error do
    val none: RFunk.none

    match(value(:none)) do |p|
      p.with :none, ->(_) { raise 'ERROR' }
    end
  end

  fun :successful do
    match(RFunk.either('YES')) do |p|
      p.with :success, ->(v) { "#{v} IT WORKED" }
    end
  end

  fun :failed do
    match(RFunk.either(nil)) do |p|
      p.with :failure, ->(_) { 'IT IS A NONE' }
    end
  end

  fun :no_match do
    match(RFunk.either(nil)) do
    end
  end
end
