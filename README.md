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

    RFunk.option('value') == RFunk.some('value')
    RFunk.option(nil) == RFunk.none

    RFunk.option('value').or('other') == RFunk.some('value')
    RFunk.option(nil).or('other') == RFunk.some('other')

## Either

Either allows us to incorporate a context of possible failure to our values while also being able to attach values to the failure,
so that they can describe what went wrong or provide some other useful info regarding the failure

### How do we use this?

    RFunk.either(-> { 'YES' }) == RFunk.success(RFunk.some('YES'))
    RFunk.either(-> { 1 / 0 }) == RFunk.failure(RFunk.some(ZeroDivisionError))
    RFunk.either(nil) == RFunk.failure(RFunk.none)
    RFunk.either(RFunk.some('YES')) == RFunk.success(RFunk.some('YES'))
    RFunk.either(RFunk.none) == RFunk.failure(RFunk.none)

    RFunk.either(-> { 'success' }).or('failure') == RFunk.success(RFunk.some('success'))
    RFunk.either(-> { 1 / 0 }).or('error') == RFunk.failure(RFunk.some('error'))
    RFunk.either(nil).or('error') == RFunk.failure(RFunk.some('error'))
    RFunk.either(nil).or(nil) == RFunk.failure(RFunk.none)
    
## Lazy

Lazy initialization is the tactic of delaying the creation of an object, the calculation of a value,
or some other expensive process until the first time it is needed.

### How do we use this?

    lazy = RFunk.lazy(-> { 'Lazy' })
    lazy.value == RFunk.some('Lazy')
    lazy.created? == true

    lazy = RFunk.lazy(-> { nil })
    lazy.value == RFunk.none
    lazy.created? == true

    lazy = RFunk.lazy(-> { 'Lazy' })
    lazy.created? == false

## Immutability

Mutability has been one of the biggest downfalls in OO programming. Why is this important?

Rich Hickey has a great way of looking at this:

> In OO, there is no real clear definition of state. Maybe it's, "the values of all the attributes within an object right now."
And it has to be "right now", because there's no language-supported way of holding on to the past.
This becomes clearer if you contrast it with the notion of identity in FP.
In the Hickeysian universe, a State is a specific value for an identity at a point in time.

### Immutable Classes

    class Customer
      include RFunk::Attribute

      attribute :first_name, String
      attribute :last_name, String
    end

    customer = Customer.new

    customer.first_name == RFunk.none
    test_customer = customer.first_name('test').last_name('test')
    test_customer.first_name == RFunk.some('test')
    test_customer.last_name == RFunk.some('test')
    test_customer.first_name = 1 == RFunk.failure(TypeError, "Expected a type of 'String' for attribute 'first_name'")

    customer = Customer.new(first_name: 'test', last_name: 'test')
    customer.first_name == RFunk.some('test')
    customer.last_name == RFunk.some('test')

### Immutable Values

This keyword has an aliase of let.

    class Customer
      include RFunk::Attribute

      fun :full_name do
        val name: 'Alex'

        value(:name)
      end

      fun :immutable_full_name do
        val name: 'Alex'
        val name: 'Alex'

        value(:name)
      end
    end

    customer = Customer.new
    customer.full_name == RFunk.some('Alex')
    customer.immutable_full_name == RFunk.failure(ImmutableError, "Could not rebind a value '[:name]', because they are immutable.")

## Design by Contract

As stated by [Wikipedia](http://en.wikipedia.org/wiki/Design_by_contract)

> Design by contract (DbC), also known as contract programming, programming by contract and design-by-contract programming,
is an approach for designing software. It prescribes that software designers should define formal, precise and verifiable
interface specifications for software components, which extend the ordinary definition of abstract data types with preconditions,
postconditions and invariants. These specifications are referred to as "contracts", in accordance with a conceptual
metaphor with the conditions and obligations of business contracts.

### How do we use this?

    fun :say_hello do |name|
      pre {
        assert { name == RFunk.some('Bob') }
      }

      body {
        val return: "Hello #{name}!"
        value(:return)
      }

      post {
        value(:return) == RFunk.some('Hello Bob!')
      }
    end
    
## Types

RFunk has the ability to specify types as a part of a function definition.

### Return Types

    fun :say_hello => String do |name|
      pre {
        assert { name == RFunk.some('Bob') }
      }

      body {
        val return: "Hello #{name}!"
        value(:return)
      }

      post {
        value(:return) == RFunk.some('Hello Bob!')
      }
    end
    
If the return type is not a string we would get the following error:
 
    RFunk.failure(TypeError, "Expected a type of 'String' for return 'say_hello'")
    
### Parameter Types

    fun :say_hello => 'String -> String' do |name|
      pre {
        assert { name == RFunk.some('Bob') }
      }

      body {
        val return: "Hello #{name}!"
        value(:return)
      }

      post {
        value(:return) == RFunk.some('Hello Bob!')
      }
    end
    
If the parameter type is not a string we would get the following error:
 
    RFunk.failure(TypeError, "Expected a type of 'String' for parameter '1'")

### Pattern Matching

You can also do some pattern Matching

    fun :something do
      match(RFunk.some('YES')) do |p|
        p.with :some, ->(v) { "#{v} IT WORKED" }
      end
    end

Would return:

    RFunk.some('YES IT WORKED')

The only supported types are option and either.
    
## Functions

As you saw in the above examples, you can define your own functions using the fun keyword. This keyword has
aliases of fn, func and defn.

## Pipeline

This is similar to the pipeline operator in Unix

    RFunk.option({ a: 1 }).pipe { |h| h.to_s }.pipe { |s| "#{s}, hello" }
    
Would return

    RFunk.some('{:a=>1}, hello')
    
## Third party libraries

We have added the following dependencies:

* [concurrent-ruby](https://github.com/ruby-concurrency/concurrent-ruby)
* [ice_nine](https://github.com/dkubb/ice_nine)
* [hamster](https://github.com/hamstergem/hamster)

This will allow you to use more functional concepts.

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
