class VariableClass
  include RFunk::Attribute

  attribute :first_name, String
  attribute :last_name, String

  fun :full_name do |first_name, last_name|
    var first_name: first_name
    var last_name: last_name

    first_name(var(:first_name)).last_name(var(:last_name))
  end

  fun :undefined do
    var(:hello)
  end

  fun :multiple_parameters do |m|
    var hello: m
    var(:hello)
  end

  fun :declare_valid do
    var hello: 'Hello'
    var(:hello)
  end

  fun :declare_multiple do
    var hello: 'Hello'
    var multiple: 'Multiple'

    var(:multiple)
  end

  fun :override_existing do
    var hello: 'Hello'
    var hello: 'Hello'
  end
end
