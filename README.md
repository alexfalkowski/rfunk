# rfunk

The concepts behind this gem are not new. They have been around for decades.

## Option/Maybe

Maybe represents computations which might "go wrong", in the sense of not returning a value. Why is this important?

Tony Hoare apologized for inventing the null reference:

> I call it my billion-dollar mistake. It was the invention of the null reference in 1965. At that time,
I was designing the first comprehensive type system for references in an object oriented language (ALGOL W).
My goal was to ensure that all use of references should be absolutely safe, with checking performed automatically by the compiler.
But I couldn't resist the temptation to put in a null reference, simply because it was so easy to implement.
This has led to innumerable errors, vulnerabilities, and system crashes, which have probably caused a billion dollars of pain and damage in the last forty years.

### How do we use this?

    Option('value') == Some('value')
    Option(nil) == None()

    Option('value').or('other') == Some('value')
    Option(nil).or('other') == Some('other')

## Either

Either allows us to incorporate a context of possible failure to our values while also being able to attach values to the failure,
so that they can describe what went wrong or provide some other useful info regarding the failure

### How do we use this?

    Either(-> { 'YES' }) == Success(Some('YES'))
    Either(-> { 1 / 0 }) == Failure(Some(ZeroDivisionError))
    Either(nil) == Failure(None())
    Either(Some('YES')) == Success(Some('YES'))
    Either(None()) == Failure(None())

    Either(-> { 'success' }).or('failure') == Success(Some('success'))
    Either(-> { 1 / 0 }).or('error') == Failure(Some('error'))
    Either(nil).or('error') == Failure(Some('error'))
    Either(nil).or(nil) == Failure(None())

## Immutability

Mutability has been one of the biggest downfalls in OO programming. Why is this important?

Rich Hickey has a great way of looking at this:

> In OO, there is no real clear definition of state. Maybe it's, "the values of all the attributes within an object right now."
And it has to be "right now", because there's no language-supported way of holding on to the past.
This becomes clearer if you contrast it with the notion of identity in FP.
In the Hickeysian universe, a State is a specific value for an identity at a point in time.

### How do we use this?

    class Customer
      include RFunk::Attribute

      attribute :first_name, String
      attribute :last_name, String
    end

    customer = Customer.new

    customer.first_name == None()
    test_customer = customer.first_name('test').last_name('test')
    test_customer.first_name == Some('test')
    test_customer.last_name == Some('test')
    test_customer.first_name = 1 == Failure(TypeError, "Expected a type of 'String' for attribute 'first_name'")

    customer = Customer.new(first_name: 'test', last_name: 'test')
    customer.first_name == Some('test')
    customer.last_name == Some('test')

## Lazy

Lazy initialization is the tactic of delaying the creation of an object, the calculation of a value,
or some other expensive process until the first time it is needed.

### How do we use this?

    lazy = Lazy(-> { 'Lazy' })
    lazy.value == Some('Lazy')
    lazy.created? == true

    lazy = Lazy(-> { nil })
    lazy.value == None()
    lazy.created? == true

    lazy = Lazy(-> { 'Lazy' })
    lazy.created? == false

## Contributing to rfunk

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2014 Alex Falkowski. See LICENSE.txt for
further details.
