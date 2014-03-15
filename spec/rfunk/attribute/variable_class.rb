class VariableClass
  include RFunk::Attribute

  def declare_valid
    var hello: 'Hello'

    var(:hello)
  end

  def declare_multiple
    var hello: 'Hello'
    var multiple: 'Multiple'

    var(:multiple)
  end

  def override_existing
    var hello: 'Hello'
    var hello: 'Hello'
  end
end
