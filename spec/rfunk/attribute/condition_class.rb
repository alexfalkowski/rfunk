class ConditionClass
  include RFunk::Attribute

  attribute :first_name, String
  attribute :last_name, String

  fun :valid do |arg|
    val arg: arg

    pre {
      value(:arg) == RFunk.some('test')
    }

    body {
      val return: value(:arg)
      value(:return)
    }

    post {
      value(:return) == RFunk.some('test')
    }
  end

  fun :invalid do |arg|
    val arg: arg

    pre {
      value(:arg) == RFunk.some('test')
    }

    body {
      val return: value(:arg)
      value(:return)
    }

    post {
      value(:return) == RFunk.some('not')
    }
  end

  fun :full_name do |first_name, last_name|
    val first_name: first_name
    val last_name: last_name

    body {
      first_name(value(:first_name)).last_name(value(:last_name))
    }
  end

  fun :assert_argument => String do |arg|
    val arg: arg

    pre {
      assert { value(:arg) == RFunk.some('test') }
    }

    body {
      val return: value(:arg)
      value(:return)
    }

    post {
      value(:return) == RFunk.some('test')
    }
  end

  fun :invalid_return_type => Integer do |arg|
    val arg: arg

    pre {
      assert { value(:arg) == RFunk.some('test') }
    }

    body {
      val return: value(:arg)
      value(:return)
    }

    post {
      value(:return) == RFunk.some('test')
    }
  end
end
