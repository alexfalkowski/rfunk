require 'spec_helper'
require_relative 'attribute_class'
require_relative 'customer'

describe RFunk::Attribute do
  context 'AttributeClass' do
    context 'has a get attribute that defaults to Nothing' do
      Given(:node) { AttributeClass.new }
      When(:result) { node.name }
      Then { result == Nothing }
    end

    context 'sets an attribute' do
      Given(:node) { AttributeClass.new }
      When(:result) { node.name('test') }
      Then { not result.equal? node  }
      Then { result.name == Some('test') }
    end

    context 'String' do
      context 'replace the string value' do
        Given(:node) { AttributeClass.new }
        Given(:new_node) { node.name('test') }
        When(:result) { new_node.name.replace('REALLY_DONKEY') }
        Then { result == Failure(RuntimeError, "can't modify frozen String") }
      end

      context 'instance_variable_set the string value' do
        Given(:node) { AttributeClass.new }
        Given(:new_node) { node.name('test') }
        When(:result) { new_node.instance_variable_set(:@name, 'update') }
        Then { result == Failure(RuntimeError, "can't modify frozen AttributeClass") }
      end
    end

    context 'Array' do
      context 'replace the array value' do
        Given(:node) { AttributeClass.new }
        Given(:new_node) { node.array([1, 2, 3]) }
        When(:result) { new_node.array << 4 }
        Then { result == Failure(RuntimeError, "can't modify frozen Array") }
      end

      context 'instance_variable_set the array value' do
        Given(:node) { AttributeClass.new }
        Given(:new_node) { node.array([1, 2, 3]) }
        When(:result) { new_node.instance_variable_set(:@array, [1, 2, 3, 4]) }
        Then { result == Failure(RuntimeError, "can't modify frozen AttributeClass") }
      end

      context 'Hash with Array' do
        context 'replace the array value' do
          Given(:node) { AttributeClass.new }
          Given(:new_node) { node.hash(a: [1, 2, 3]) }
          When(:result) { new_node.hash[:a] << 4 }
          Then { result == Failure(RuntimeError, "can't modify frozen Array") }
        end
      end
    end

    context 'Wrong Type' do
      Given(:node) { AttributeClass.new }
      When(:result) { node.hash([1, 2, 3]) }
      Then { result == Failure(TypeError, "Expected a type of 'Hash' for attribute 'hash'") }
    end

    context 'Customer' do
      context 'sets multiple attributes' do
        Given(:node) { Customer.new }
        When(:result) { node.first_name('test').last_name('test') }
        Then { result.first_name == Some('test') }
        Then { result.last_name == Some('test') }
      end

      context 'allows creation with constructor parameters' do
        When(:result) { Customer.new(first_name: 'test', last_name: 'test') }
        Then { result.first_name == Some('test') }
        Then { result.last_name == Some('test') }
      end

      context 'does not allow creation with invalid parameters' do
        When(:result) { Customer.new(first_name: 'test', donkey: 'test') }
        Then { result == Failure(RFunk::NotFoundError, "Attribute with name 'donkey' does not exist. The only available attributes are '{:first_name=>String, :last_name=>String}'") }
      end

      context 'does not allow creation with invalid type' do
        When(:result) { Customer.new(first_name: 'test', last_name: []) }
        Then { result == Failure(TypeError, "Expected a type of 'String' for attribute 'last_name'") }
      end
    end
  end
end
