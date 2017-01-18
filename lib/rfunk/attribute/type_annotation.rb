module RFunk
  class TypeAnnotation
    attr_reader :parameters, :return

    def initialize(annotation)
      split = (annotation || '').split('->').map(&:strip)
      @parameters = create_types(split.length > 1 ? Array(split.first) : [])
      @return = create_types(Array(split.last))
    end

    private

    def create_types(parameters)
      parameters.flat_map { |v| v.split(',') }.map(&:strip).map { |p| Object.const_get(p) }
    end
  end
end
