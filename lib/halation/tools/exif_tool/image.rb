require 'mini_exiftool'

module Halation
  # Image interface implementation for ExifTool.
  # Available as apt package `libimage-exiftool-perl`.
  # @see http://www.sno.phy.queensu.ca/~phil/exiftool/
  class ExifToolImage

    # @param file_path [String] Path to the image file.
    def initialize(file_path)
      @image = MiniExiftool.new(file_path)
    end

    # Read an Exif tag.
    # @param tag [String, Symbol]
    def [](tag)
      @image[tag]
    end

    # Write an Exif tag.
    # @param tag [String, Symbol]
    # @param value [String]
    def []=(tag, value)
      @image[tag] = value
    end

    # Save the Exif data to the image file.
    def save
      @image.save
    end

  end
end
