module RFunk
  module Attribute
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def attribute(name, type)
        variable_name = "@#{name}"
        self.send :define_method, name do |value = nil|
          if value
            raise "Expected a type of '#{type}'" unless value.instance_of?(type)

            self.class.new.tap { |object|
              object.instance_variable_set(variable_name, value)
              object.deep_freeze
            }
          else
            Some(self.instance_variable_get(variable_name))
          end
        end
      end
    end
  end
end
