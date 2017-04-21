module RFunk
  class Immutable
    def create(options)
      instance = options.fetch(:instance)
      variable_name = options.fetch(:variable_name)
      value = options.fetch(:value)

      instance.class.new.tap do |object|
        create_instance_variables(instance, object, variable_name)

        object.instance_variable_set(variable_name, value)
        object.deep_freeze if should_deep_freeze?(value)
      end
    end

    private

    def should_deep_freeze?(value)
      ['Hamster'].none? { |m| value.class.to_s.include?(m) }
    end

    def create_instance_variables(instance, object, variable_name)
      instance.instance_variables.reject { |v| v == variable_name }.each do |v|
        previous_value = instance.instance_variable_get(v)
        object.instance_variable_set(v, previous_value)
      end
    end
  end
end
