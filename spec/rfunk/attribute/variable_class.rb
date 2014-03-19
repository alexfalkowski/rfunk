class VariableClass
  include RFunk::Attribute

  attribute :first_name, String
  attribute :last_name, String

  fun :full_name do |f, first_name, last_name|
    f.var first_name: first_name
    f.var last_name: last_name

    first_name(f.var(:first_name)).last_name(f.var(:last_name))
  end

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
