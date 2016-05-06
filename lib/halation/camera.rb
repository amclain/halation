require 'halation/attr_helpers'

module Halation
  class Config
    # A camera profile.
    class Camera
      extend Halation::AttrHelpers

      attr_reader_str_or_nil :tag
      attr_reader_str_or_nil :make
      attr_reader_str_or_nil :model
      attr_reader :lenses

      def initialize(yaml)
        @tag = yaml["tag"]
        @make = yaml["make"]
        @model = yaml["model"]
        @lenses = []

        yaml["lenses"].each do |lens|
          @lenses << Lens.new(lens)
        end
      end
    end

    # A lens profile.
    class Lens
      extend Halation::AttrHelpers

      attr_reader_str_or_nil :tag
      attr_reader_str_or_nil :model
      attr_reader_int_or_nil :focal_length

      def initialize(yaml)
        @tag = yaml["tag"]
        @model = yaml["model"]
        @focal_length = yaml["focal_length"]
      end
    end
  end
end
