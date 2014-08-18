module RFunk
  class TypeAnnotation
    attr_reader :parameters, :return

    def initialize(annotation)
      case Option(annotation)
      when Some
        @annotation = annotation.split('->')
        @parameters = if @annotation.count == 2
                        @annotation[0].split(',').map { |p| Object.const_get(p.strip) }
                      else
                        []
                      end
        @return = if @annotation.count == 2
                    Object.const_get(@annotation[1].strip)
                  else
                    Object.const_get(@annotation[0].strip)
                  end
      else
        @parameters = []
        @return = None()
      end
    end
  end
end
