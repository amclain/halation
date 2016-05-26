require 'yaml'
require_relative 'coerce'
require_relative 'config/camera'

module Halation
  # Application-wide configuraton.
  class Config
    DEFAULT_CONFIG_PATH = File.expand_path("~/.halation/config.yml").freeze

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
    def load_file(file_path = nil)
      file_path ||= DEFAULT_CONFIG_PATH

      reset

      YAML.load_file(file_path).tap do |config|
        @artist = Coerce.string(config["artist"])
        @copyright = Coerce.string(config["copyright"])

        (config["cameras"] || []).each do |camera|
          @cameras << Camera.new(camera)
        end
      end
    end

    # @return [String] list of configuration settings.
    def to_s
      [
        "Artist: #{@artist}",
        "Copyright: #{@copyright}",
        @cameras.map(&:to_s)
      ].join("\n")
    end
  end
end
