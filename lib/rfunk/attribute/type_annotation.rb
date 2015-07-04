module RFunk
  class TypeAnnotation
    attr_reader :parameters, :return

    def initialize(annotation)
      option = RFunk::Option(annotation)
      split = option.split('->')
      parameters = split.select { |v| v.count == 2 }

      @parameters = parameters.flat_map { |v| v[0].split(',').map { |p| Object.const_get(p.strip) } }
      @return = RFunk::Option(split.map { |v|
        v.count == 2 ? Object.const_get(v[1].strip) : Object.const_get(v[0].strip)
      }.first).value
    end
  end
end
