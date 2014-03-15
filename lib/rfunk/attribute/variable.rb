module RFunk
  module Variable
    def var(options)
      name = "#{self.class.to_s.downcase}_#{caller_locations(1, 1)[0].label}"
      name = variable_name("#{name}_#{Digest::MD5.hexdigest(name)}")

      if options.is_a?(Hash)
        variable = self.instance_variable_get(name)

        if variable
          ErrorChecking.new.raise_immutable(options, variable)
          self.instance_variable_set(name, variable.merge(options))
        else
          self.instance_variable_set(name, options)
        end
      else
        Some(self.instance_variable_get(name)[options])
      end
    end
  end
end
