class ValueClass
  include RFunk::Attribute

  attribute :first_name, String
  attribute :last_name, String

  fun :full_name do |first_name, last_name|
    val first_name: first_name
    val last_name: last_name

    first_name(val(:first_name)).last_name(val(:last_name))
  end

  func :undefined do
    val(:hello)
  end

  defn :parameter => 'String -> String' do |m|
    val hello: m.to_s
    val(:hello)
  end

  fn :declare_valid => String do
    val hello: 'Hello'
    val(:hello)
  end

  fun :invalid_return_type => Integer do
    val string: 'Hello'
    val(:string)
  end

  fun :declare_multiple do
    val hello: 'Hello'
    val multiple: 'Multiple'

    val(:multiple)
  end

  fun :override_existing do
    val hello: 'Hello'
    val hello: 'Hello'
  end
end
