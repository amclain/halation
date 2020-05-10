module Halation
  # A collection of methods to coerce values into a desired type.
  class Coerce

    # @return [String, nil]
    def self.string(value)
      value && value.to_s
    end

    # @return [Integer, nil]
    def self.integer(value)
      value && value.to_i
    end

    # @return [Boolean]
    def self.boolean(value)
      !!value
    end

    # @return [Date, nil]
    def self.date(value)
      value && Time.parse(value)
    end

  end
end
