require 'spec_helper'
require_relative 'example_class'

describe RFunk::Immutable do
  context 'ExampleNode' do
    context 'String' do
      context 'replace the string value' do
        Given(:node) { ExampleClass.new('DONKEY') }
        When(:result) { node.value.replace('REALLY_DONKEY') }
        Then { result == Failure(RuntimeError, "can't modify frozen String") }
      end

      context 'instance_variable_set the string value' do
        Given(:node) { ExampleClass.new('DONKEY') }
        When(:result) { node.instance_variable_set(:@value, 'update') }
        Then { result == Failure(RuntimeError, "can't modify frozen ExampleClass") }
      end
    end

    context 'Array' do
      context 'replace the array value' do
        Given(:node) { ExampleClass.new([1, 2, 3]) }
        When(:result) { node.value << 4 }
        Then { result == Failure(RuntimeError, "can't modify frozen Array") }
      end

      context 'instance_variable_set the array value' do
        Given(:node) { ExampleClass.new([1, 2, 3]) }
        When(:result) { node.instance_variable_set(:@value, [1, 2, 3, 4]) }
        Then { result == Failure(RuntimeError, "can't modify frozen ExampleClass") }
      end
    end

    context 'Hash with Array' do
      context 'replace the array value' do
        Given(:node) { ExampleClass.new({a: [1, 2, 3]}) }
        When(:result) { node.value[:a] << 4 }
        Then { result == Failure(RuntimeError, "can't modify frozen Array") }
      end
    end
  end
end
