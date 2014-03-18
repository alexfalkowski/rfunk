class VariableClass
  include RFunk::Attribute

  fun(:undefined) { |f|
    f.var(:hello)
  }

  fun(:multiple_parameters) { |f, m|
    f.var hello: m
    f.var(:hello)
  }

  fun :declare_valid do |f|
    f.var hello: 'Hello'
    f.var(:hello)
  end

  fun :declare_multiple do |f|
    f.var hello: 'Hello'
    f.var multiple: 'Multiple'

    f.var(:multiple)
  end

  fun :override_existing do |f|
    f.var hello: 'Hello'
    f.var hello: 'Hello'
  end
end
