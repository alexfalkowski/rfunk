module RFunk
  def Some(value)
    if Maybe.nothing?(value)
      Nothing
    else
      Just.new(value)
    end
  end
end
