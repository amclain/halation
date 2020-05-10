require 'yaml'
require_relative 'coerce'
require_relative 'roll/frame'

module Halation
  # Settings for a roll of film.
  class Roll
    # Artist for the roll of film.
    attr_reader :artist
    # Copyright for the roll of film.
    attr_reader :copyright
    # Default date a frame was captured for all frames,
    # in ISO 8601 format (optional).
    attr_reader :date_captured
    # Tag of the cameara used.
    attr_reader :camera
    # Tag of the default lens used (optional).
    attr_reader :lens
    # ISO of the roll of film.
    attr_reader :iso
    # Array of frames on the roll of film.
    attr_reader :frames

    def initialize
      reset
    end

    # Reset the configuration to default values.
    def reset
      @artist = nil
      @copyright = nil
      @date_captured = nil
      @camera = nil
      @lens = nil
      @iso = nil
      @frames = []
    end

    # Load the settings from a YAML file.
    def load_file(file_path)
      reset

      YAML.load_file(file_path).tap do |roll|
        @artist = Coerce.string(roll["artist"])
        @copyright = Coerce.string(roll["copyright"])
        @date_captured = Coerce.date(roll["date_captured"])
        @camera = Coerce.string(roll["camera"])
        @lens = Coerce.string(roll["lens"])
        @iso = Coerce.integer(roll["iso"])

        (roll["frames"] || []).each do |frame|
          @frames << Frame.new(frame)
        end
      end
    end

  end
end
