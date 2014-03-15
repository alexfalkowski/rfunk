module RFunk
  class Immutable
    def create(options)
      instance = options.fetch(:instance)
      variable_name = options.fetch(:variable_name)
      value = options.fetch(:value)

      instance.class.new.tap { |object|
        instance.instance_variables.select { |v| v != variable_name }.each { |v|
          previous_value = instance.instance_variable_get(v)
          object.instance_variable_set(v, previous_value)
        }

        object.instance_variable_set(variable_name, value)
        object.deep_freeze
      }
    end
  end
end
