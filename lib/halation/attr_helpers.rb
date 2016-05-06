module Halation
  # Class attr helpers.
  # Extend this module to opt-in to its functionality.
  module AttrHelpers
    # @return [String, nil]
    def attr_reader_str_or_nil(*sym)
      with_instance_variables(*sym) { |value| value &&= value.to_s }
    end

    # @return [Integer, nil]
    def attr_reader_int_or_nil(*sym)
      with_instance_variables(*sym) { |value| value &&= value.to_i }
    end

    private

    def with_instance_variables(*sym, &block)
      sym.each do |_sym|
        define_method(_sym) {
          block.call(instance_variable_get("@#{_sym}"))
        }
      end
    end
  end
end
