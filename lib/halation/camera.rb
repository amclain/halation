require 'halation/coerce'
require 'halation/lens'

module Halation
  class Config
    # A camera profile.
    class Camera
      attr_reader :tag
      attr_reader :make
      attr_reader :model
      attr_reader :lenses

      def initialize(yaml)
        @tag = Coerce.string(yaml["tag"])
        @make = Coerce.string(yaml["make"])
        @model = Coerce.string(yaml["model"])
        @lenses = []

        yaml["lenses"].each do |lens|
          @lenses << Lens.new(lens)
        end
      end
    end
  end
end
