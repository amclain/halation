require 'yaml'
require 'halation/coerce'
require 'halation/config/camera'

module Halation
  # Application-wide configuraton.
  class Config
    attr_reader :artist
    attr_reader :copyright
    attr_reader :cameras

    def initialize
      reset
    end

    # Reset the configuration to default values.
    def reset
      @artist = nil
      @copyright = nil
      @cameras = []
    end

    # Load the configuration from a YAML file.
    def load_file(file_path)
      reset

      YAML.load_file(file_path).tap do |config|
        @artist = Coerce.string(config["artist"])
        @copyright = Coerce.string(config["copyright"])

        (config["cameras"] || []).each do |camera|
          @cameras << Camera.new(camera)
        end
      end
    end

  end
end
