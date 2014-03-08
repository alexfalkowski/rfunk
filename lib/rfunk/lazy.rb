module RFunk
  class Lazy
    def initialize(lambda)
      @lambda = lambda
      @created = false
    end

    def value
      Option(@value ||= lambda.call.tap { self.created = true })
    end

    def created?
      created
    end

    private

    attr_reader :lambda
    attr_accessor :created
  end

  def Lazy(lambda)
    Lazy.new(lambda)
  end
end
