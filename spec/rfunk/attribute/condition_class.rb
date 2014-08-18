class ConditionClass
  include RFunk::Attribute

  attribute :first_name, String
  attribute :last_name, String

  fun :valid do |arg|
    var arg: arg

    pre {
      var(:arg) == Some('test')
    }

    body {
      var return: var(:arg)
      var(:return)
    }

    post {
      var(:return) == Some('test')
    }
  end

  fun :invalid do |arg|
    var arg: arg

    pre {
      var(:arg) == Some('test')
    }

    body {
      var return: var(:arg)
      var(:return)
    }

    post {
      var(:return) == Some('not')
    }
  end

  fun :full_name do |first_name, last_name|
    var first_name: first_name
    var last_name: last_name

    body {
      first_name(var(:first_name)).last_name(var(:last_name))
    }
  end

  fun :assert_argument => String do |arg|
    var arg: arg

    pre {
      assert { var(:arg) == Some('test') }
    }

    body {
      var return: var(:arg)
      var(:return)
    }

    post {
      var(:return) == Some('test')
    }
  end

  fun :invalid_return_type => Integer do |arg|
    var arg: arg

    pre {
      assert { var(:arg) == Some('test') }
    }

    body {
      var return: var(:arg)
      var(:return)
    }

    post {
      var(:return) == Some('test')
    }
  end
end
