module RFunk
  class Lazy
    def initialize(lambda)
      @lambda = lambda
    end

    def value
      Option(@value ||= lambda.call)
    end

    private

    attr_reader :lambda
  end

  def Lazy(lambda)
    Lazy.new(lambda)
  end
end
