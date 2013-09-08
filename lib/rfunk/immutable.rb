module RFunk
  module Immutable
    def new(*)
      object = super
      object.instance_variables.each { |var| object.instance_variable_get(var).deep_freeze }
      object.deep_freeze
    end
  end
end
