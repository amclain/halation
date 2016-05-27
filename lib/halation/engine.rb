require_relative 'config'
require_relative 'roll'
require_relative 'tools/exif_tool/image'

module Halation
  # Performs modifications to the image Exif data.
  class Engine
    attr_accessor :image_extensions

    # @option opts [String] :config_path (nil)
    #   Override the config file that should be used.
    # @option opts [String] :working_dir (".")
    #   Override the working directory (contains images and roll.yml).
    # @option opts [Array<String>] :image_extensions
    #   Override the list of image extensions to search for.
    def initialize(opts = {})
      config_path = opts[:config_path]
      @working_dir = File.expand_path(opts[:working_dir] || ".")
      @image_extensions = opts[:image_extensions] || ["tif", "tiff", "jpg", "jpeg"]

      @config = Config.new
      @config.load_file(config_path)

      @roll = Roll.new
      @roll.load_file("#{@working_dir}/roll.yml")
    end

    # @return [Array<String>] detected image files to process, in ascending
    #   alphabetical order.
    def image_files
      Dir[*@image_extensions.map { |ext| "#{@working_dir}/*.#{ext}" }].sort
    end

    # Process the batch of images.
    def run
      # TODO: Implement
      raise NotImplementedError
    end

  end
end
