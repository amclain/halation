require_relative 'config'
require_relative 'roll'
require_relative 'tools/exif_tool/image'

module Halation
  # Performs modifications to the image Exif data.
  class Engine
    # Array of image extensions to search for.
    attr_accessor :image_extensions
    # Suppress output to stdout if true.
    attr_accessor :silent

    attr_reader :config
    attr_reader :roll

    # @see #run
    def self.run(opts = {})
      new(opts).run
    end

    # @option opts [String] :config_path (nil)
    #   Override the config file that should be used.
    # @option opts [String] :working_dir (".")
    #   Override the working directory (contains images and roll.yml).
    # @option opts [Array<String>] :image_extensions
    #   Override the list of image extensions to search for.
    # @option opts [Boolean] :silent
    #   Suppress output to stdout.
    def initialize(opts = {})
      config_path = opts[:config_path]
      @silent = !!opts[:silent]
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
      Dir[*@image_extensions.map { |ext| "#{@working_dir}/*.#{ext}" }]
        .sort[0...@roll.frames.count]
    end

    # Process the batch of images.
    def run
      _image_files = image_files

      specified_camera = @roll.camera
      camera = @config.cameras.find { |camera| camera.tag == specified_camera }
      raise "Camera #{specified_camera} not found in config.yml" unless camera

      @roll.frames.each_with_index do |frame, i|
        break if i >= _image_files.count

        specified_lens = frame.lens || @roll.lens
        lens = camera.lenses.find { |lens| lens.tag == specified_lens }
        raise "Lens #{specified_lens} not found for frame #{frame.number}" unless lens

        relative_path = _image_files[i].gsub(%r(^#{Dir.pwd}/), "")
        puts "Processing frame #{frame.number}\n   #{relative_path}" unless @silent

        ExifToolImage.new(_image_files[i]).tap do |exif|
          exif["Artist"] = @roll.artist || @config.artist
          exif["Copyright"] = @roll.copyright || @config.copyright
          
          date_captured = frame.date_captured || @roll.date_captured
          exif["DateTimeOriginal"] = date_captured
          exif["CreateDate"] = date_captured

          exif["Make"] = camera.make
          exif["Model"] = camera.model
          exif["LensModel"] = lens.model
          exif["ISO"] = @roll.iso
          exif["ExposureTime"] = frame.shutter || @roll.shutter
          exif["FNumber"] = frame.aperture || @roll.aperture
          exif["FocalLength"] = frame.focal_length || lens.focal_length || @roll.focal_length
          exif["Flash"] = frame.flash ? 1 : 0
          exif["Orientation"] = frame.orientation || 1

          exif.save
        end
      end
    end

  end
end
