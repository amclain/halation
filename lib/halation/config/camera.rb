require_relative '../coerce'
require_relative 'lens'

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

      # @return [String]
      def to_s
        "Camera\n" <<
        [
          "Tag: #{tag}",
          "Make: #{make}",
          "Model: #{model}",
          @lenses.map(&:to_s).join("\n")
        ]
          .join("\n")
          .lines
          .map { |line| "   #{line}" }
          .join
      end
    end
  end
end
