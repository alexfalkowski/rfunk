class ValueClass
  include RFunk::Attribute

  attribute :first_name, String
  attribute :last_name, String

  fun :full_name do |first_name, last_name|
    val first_name: first_name
    val last_name: last_name

    first_name(value(:first_name)).last_name(value(:last_name))
  end

  func :undefined do
    value(:hello)
  end

  defn :parameter => 'String -> String' do |m|
    let hello: m.to_s
    value(:hello)
  end

  fn :declare_valid => String do
    val hello: 'Hello'
    value(:hello)
  end

  fun :invalid_return_type => Integer do
    val string: 'Hello'
    value(:string)
  end

  fun :declare_multiple do
    val hello: 'Hello'
    val multiple: 'Multiple'

    value(:multiple)
  end

  fun :override_existing do
    val hello: 'Hello'
    val hello: 'Hello'
  end
end
