class ConditionClass
  include RFunk::Attribute

  attribute :first_name, String
  attribute :last_name, String

  fun :valid do |arg|
    val arg: arg

    pre {
      val(:arg) == RFunk.some('test')
    }

    body {
      val return: val(:arg)
      val(:return)
    }

    post {
      val(:return) == RFunk.some('test')
    }
  end

  fun :invalid do |arg|
    val arg: arg

    pre {
      val(:arg) == RFunk.some('test')
    }

    body {
      val return: val(:arg)
      val(:return)
    }

    post {
      val(:return) == RFunk.some('not')
    }
  end

  fun :full_name do |first_name, last_name|
    val first_name: first_name
    val last_name: last_name

    body {
      first_name(val(:first_name)).last_name(val(:last_name))
    }
  end

  fun :assert_argument => String do |arg|
    val arg: arg

    pre {
      assert { val(:arg) == RFunk.some('test') }
    }

    body {
      val return: val(:arg)
      val(:return)
    }

    post {
      val(:return) == RFunk.some('test')
    }
  end

  fun :invalid_return_type => Integer do |arg|
    val arg: arg

    pre {
      assert { val(:arg) == RFunk.some('test') }
    }

    body {
      val return: val(:arg)
      val(:return)
    }

    post {
      val(:return) == RFunk.some('test')
    }
  end
end
