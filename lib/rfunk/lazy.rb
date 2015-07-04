module RFunk
  class Lazy
    def initialize(lambda)
      @lambda = lambda
      @created = false
      @atomic = Concurrent::Atomic.new
    end

    def value
      atomic.update { @value ||= lambda.call.tap { self.created = true } }
      RFunk::Option(atomic.value)
    end

    def created?
      created
    end

    private

    attr_reader :lambda, :atomic
    attr_accessor :created
  end

  def Lazy(lambda)
    RFunk::Lazy.new(lambda)
  end
end
