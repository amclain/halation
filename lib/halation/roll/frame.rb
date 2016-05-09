require 'halation/coerce'

module Halation
  class Roll
    # A frame on the roll of film.
    class Frame
      # Frame number.
      attr_reader :number
      # Date the frame was taken.
      attr_reader :date
      # Tag of the lens used.
      attr_reader :lens
      # Focal length of the lens, if not specified by the lens profile
      # (a zoom lens).
      attr_reader :focal_length
      # @todo spec
      # Shutter speed.
      # @example "1/125", "0.5" (half second), "15" (seconds), "120" (2 minutes)
      attr_reader :shutter
      # F-number of the aperture setting.
      attr_reader :aperture
      # True if flash was fired.
      attr_reader :flash
      # @todo design & spec parameter
      attr_reader :orientation

      def initialize(yaml)
        @number = Coerce.integer(yaml["number"])
        @date = Coerce.string(yaml["date"])
        @lens = Coerce.string(yaml["lens"])
        @focal_length = Coerce.integer(yaml["focal_length"])
        @shutter = Coerce.string(yaml["shutter"])
        @aperture = Coerce.string(yaml["aperture"])
        @flash = Coerce.boolean(yaml["flash"])
        @orientation = 0 # TODO: Implement
      end

    end
  end
end
