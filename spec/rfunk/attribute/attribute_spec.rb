require_relative 'attribute_class'
require_relative 'inherited_class'
require_relative 'empty_attribute_class'
require_relative 'customer'

describe RFunk::Attribute do
  context 'EmptyAttributeClass' do
    When(:value) { EmptyAttributeClass.new }
    Then { value != RFunk::Failure }
  end

  context 'AttributeClass' do
    context 'has a get attribute that defaults to Nothing' do
      Given(:node) { AttributeClass.new }
      When(:result) { node.name }
      Then { result == RFunk.none }
    end

    context 'sets an attribute' do
      Given(:node) { AttributeClass.new }
      When(:result) { node.name('test') }
      Then { not result.equal? node }
      Then { result.name == RFunk.some('test') }
    end

    context 'String' do
      context 'replace the string value' do
        Given(:node) { AttributeClass.new }
        Given(:new_node) { node.name('test') }
        When(:result) { new_node.name.replace('REALLY_DONKEY') }
        Then { result == Failure(RuntimeError, /frozen/) }
      end

      context 'instance_variable_set the string value' do
        Given(:node) { AttributeClass.new }
        Given(:new_node) { node.name('test') }
        When(:result) { new_node.instance_variable_set(:@name, 'update') }
        Then { result == Failure(RuntimeError, /frozen/) }
      end
    end

    context 'Array' do
      context 'replace the array value' do
        Given(:node) { AttributeClass.new }
        Given(:new_node) { node.array([1, 2, 3]) }
        When(:result) { new_node.array << 4 }
        Then { result == Failure(RuntimeError, /frozen/) }
      end

      context 'instance_variable_set the array value' do
        Given(:node) { AttributeClass.new }
        Given(:new_node) { node.array([1, 2, 3]) }
        When(:result) { new_node.instance_variable_set(:@array, [1, 2, 3, 4]) }
        Then { result == Failure(RuntimeError, /frozen/) }
      end

      context 'Hash with Array' do
        context 'replace the array value' do
          Given(:node) { AttributeClass.new }
          Given(:new_node) { node.hash(a: [1, 2, 3]) }
          When(:result) { new_node.hash[:a] << 4 }
          Then { result == Failure(RuntimeError, /frozen/) }
        end
      end

      context 'Wrong Type' do
        Given(:node) { AttributeClass.new }
        When(:result) { node.hash([1, 2, 3]) }
        Then { result == Failure(TypeError, "Expected a type of 'Hash' for attribute 'hash'") }
      end
    end

    context 'InheritedClass' do
      context 'has a get attribute that defaults to Nothing' do
        Given(:node) { InheritedClass.new }
        When(:result) { node.name }
        Then { result == RFunk.none }
      end

      context 'sets an attribute' do
        Given(:node) { InheritedClass.new }
        When(:result) { node.name('test') }
        Then { not result.equal? node }
        Then { result.name == RFunk.some('test') }
      end

      context 'String' do
        context 'replace the string value' do
          Given(:node) { InheritedClass.new }
          Given(:new_node) { node.name('test') }
          When(:result) { new_node.name.replace('REALLY_DONKEY') }
          Then { result == Failure(RuntimeError, /frozen/) }
        end

        context 'instance_variable_set the string value' do
          Given(:node) { AttributeClass.new }
          Given(:new_node) { node.name('test') }
          When(:result) { new_node.instance_variable_set(:@name, 'update') }
          Then { result == Failure(RuntimeError, /frozen/) }
        end
      end

      context 'Array' do
        context 'replace the array value' do
          Given(:node) { InheritedClass.new }
          Given(:new_node) { node.array([1, 2, 3]) }
          When(:result) { new_node.array << 4 }
          Then { result == Failure(RuntimeError, /frozen/) }
        end

        context 'instance_variable_set the array value' do
          Given(:node) { InheritedClass.new }
          Given(:new_node) { node.array([1, 2, 3]) }
          When(:result) { new_node.instance_variable_set(:@array, [1, 2, 3, 4]) }
          Then { result == Failure(RuntimeError, /frozen/) }
        end

        context 'Hash with Array' do
          context 'replace the array value' do
            Given(:node) { InheritedClass.new }
            Given(:new_node) { node.hash(a: [1, 2, 3]) }
            When(:result) { new_node.hash[:a] << 4 }
            Then { result == Failure(RuntimeError, /frozen/) }
          end
        end

        context 'Wrong Type' do
          Given(:node) { InheritedClass.new }
          When(:result) { node.hash([1, 2, 3]) }
          Then { result == Failure(TypeError, "Expected a type of 'Hash' for attribute 'hash'") }
        end
      end
    end

    context 'Customer' do
      context 'Multiple' do
        Given(:node) { Customer.new }

        context 'sets multiple attributes with default' do
          When(:result) { node.first_name('test').last_name('test') }
          Then { result.first_name == RFunk.some('test') }
          Then { result.last_name == RFunk.some('test') }
          Then { result.title == RFunk.some('Mr') }
        end

        context 'sets multiple attributes' do
          When(:result) { node.first_name('test').last_name('test').title('test') }
          Then { result.first_name == RFunk.some('test') }
          Then { result.last_name == RFunk.some('test') }
          Then { result.title == RFunk.some('test') }
        end
      end

      context 'Constructor' do
        context 'allows creation with default' do
          When(:result) { Customer.new(first_name: 'test', last_name: 'test') }
          Then { result.first_name == RFunk.some('test') }
          Then { result.last_name == RFunk.some('test') }
          Then { result.title == RFunk.some('Mr') }
        end

        context 'allows creation' do
          When(:result) { Customer.new(first_name: 'test', last_name: 'test', title: 'test') }
          Then { result.first_name == RFunk.some('test') }
          Then { result.last_name == RFunk.some('test') }
          Then { result.title == RFunk.some('test') }
        end
      end

      context 'does not allow creation with invalid parameters' do
        let(:message) {
          "Attribute with name 'donkey' does not exist. The only available attributes are '[:title, :first_name, :last_name, :options]'"
        }
        When(:result) { Customer.new(first_name: 'test', donkey: 'test') }
        Then { result == Failure(RFunk::NotFoundError, message) }
      end

      context 'does not allow creation with invalid type' do
        When(:result) { Customer.new(first_name: 'test', last_name: []) }
        Then { result == Failure(TypeError, "Expected a type of 'String' for attribute 'last_name'") }
      end

      context 'Efficient, immutable, and thread-safe collection classes for Ruby.' do
        Given(:customer) { Customer.new }

        context 'Default options' do
          Then { customer.options == RFunk.some(Hamster::Hash[name: 'Simon', gender: :male]) }
        end

        context 'replace hash value' do
          When(:result) { customer.options(customer.options.put(:name, 'James')) }
          Then { result.options == RFunk.some(Hamster::Hash[name: 'James', gender: :male]) }
        end
      end
    end
  end
end
