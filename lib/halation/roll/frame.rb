require_relative '../coerce'

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
      # 1 = Horizontal (normal) 
      # 2 = Mirror horizontal 
      # 3 = Rotate 180 
      # 4 = Mirror vertical 
      # 5 = Mirror horizontal and rotate 270 CW 
      # 6 = Rotate 90 CW 
      # 7 = Mirror horizontal and rotate 90 CW 
      # 8 = Rotate 270 CW
      attr_reader :orientation

      def initialize(yaml)
        @number = Coerce.integer(yaml["number"])
        @date = Coerce.string(yaml["date"])
        @lens = Coerce.string(yaml["lens"])
        @focal_length = Coerce.integer(yaml["focal_length"])
        @shutter = Coerce.string(yaml["shutter"])
        @aperture = Coerce.string(yaml["aperture"])
        @flash = Coerce.boolean(yaml["flash"])
        @orientation = Coerce.integer(yaml["orientation"])
      end

    end
  end
end
