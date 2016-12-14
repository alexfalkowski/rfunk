module RFunk
  class AttributeVariable
    ATTRIBUTES_VARIABLE_NAME = '@attributes'.freeze

    def add(options)
      instance = options.fetch(:instance)
      name = options.fetch(:name)
      attributes = attributes(instance)

      attributes[name] = RFunk::AttributeType.new(name, options.fetch(:type), options.fetch(:options))
      attributes(instance, attributes)
    end

    def attributes(*args)
      instance = args[0]

      if args.length == 1
        instance.instance_variable_get(ATTRIBUTES_VARIABLE_NAME) || {}
      else
        instance.instance_variable_set(ATTRIBUTES_VARIABLE_NAME, args[1])
      end
    end
  end
end
