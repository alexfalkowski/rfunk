module RFunk
  class TypeAnnotation
    attr_reader :parameters, :return

    def initialize(annotation)
      option = RFunk::Option(annotation)
      split = option.split('->')
      parameters = split.select { |v| v.count == 2 }

      @parameters = create_parameters(parameters)
      @return = create_return(split)
    end

    private

    def create_parameters(parameters)
      parameters.flat_map { |v| v[0].split(',').map { |p| Object.const_get(p.strip) } }
    end

    def create_return(split)
      RFunk::Option(split.map do |v|
                      v.count == 2 ? Object.const_get(v[1].strip) : Object.const_get(v[0].strip)
                    end.first).value
    end
  end
end
