require 'halation/coerce'

module Halation
  class Config
    # A lens profile.
    class Lens
      attr_reader :tag
      attr_reader :model
      attr_reader :focal_length

      def initialize(yaml)
        @tag = Coerce.string(yaml["tag"])
        @model = Coerce.string(yaml["model"])
        @focal_length = Coerce.integer(yaml["focal_length"])
      end
    end
  end
end
