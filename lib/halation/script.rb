require 'optparse'
require 'fileutils'

require_relative 'engine'

module Halation
  # The script that runs when the halation binary is executed.
  class Script
    private_class_method :new

    # @option opts [Boolean] :args (ARGV)
    # @option opts [Boolean] :output_stream (STDOUT)
    # @option opts [Boolean] :skip_exit (false)
    #   Don't exit the program after calling a handler that would normally exit.
    #   Used for unit testing.
    def self.run(opts = {})
      args = opts[:args] || ARGV
      output_stream = opts[:output_stream] || STDOUT
      skip_exit = !!opts[:skip_exit]
      run_engine = true

      options = {}

      OptionParser.new { |op|
        op.banner = "Usage: halation [options]"

        op.on("-c", "--config=PATH", String, "Config file path") do |config_path|
          options[:config_path] = config_path
        end

        op.on("--dry", "Dry run") do
          options[:dry_run] = true
          # TODO: Implement
          raise NotImplementedError, "Dry run option is not yet implemented."
        end

        op.on("-h", "--help", "Print this help") do
          output_stream.puts op
          run_engine = false
          exit unless skip_exit
        end

        op.on("--new-config", "Generate a new config file") do |path|
          # TODO: Implement
          raise NotImplementedError, "Generate config option is not yet implemented."
          run_engine = false
          exit unless skip_exit
        end

        op.on("--new-roll", "Generate a new roll.yml file") do
          generate_new_roll
          run_engine = false
          exit unless skip_exit
        end

        op.on("-p", "--print-config", "Print the configuration settings") do
          # TODO: Implement
          raise NotImplementedError, "Print config option is not yet implemented."
          run_engine = false
          exit unless skip_exit
        end

        op.on("-r", "--recursive", "Traverse into subdirectories") do
          # TODO: Implement
          raise NotImplementedError, "Recursive option is not yet implemented."
        end

        op.on("--silent", "Suppress messages to stdout.") do
          options[:silent] = true
        end

        op.on("-v", "--version", "Print the version information") do
          output_stream.puts "halation #{Halation::VERSION}"
          run_engine = false
          exit unless skip_exit
        end
      }.parse!(args)

      Halation::Engine.run(options) if run_engine
    end

    # Generate a new roll.yml file.
    # Copies "~/.halation/templates/roll.yml" if it exists, otherwise it uses
    # a default template.
    def self.generate_new_roll
      roll_path = "roll.yml"

      if File.exists?(roll_path)
        output_stream.puts "A roll.yml file already exists in this directory."
        return
      end

      # TODO: Make this configurable from config.yml
      roll_template_path = File.expand_path("~/.halation/templates/roll.yml")

      if File.exists?(roll_template_path)
        FileUtils.cp(roll_template_path, ".")
      else
        File.open(roll_path, "w") do |f|
          f.puts new_roll_content
        end
      end
    end

    private

    # @return [String] roll.yml default content
    def self.new_roll_content
      today = Time.now.strftime("%Y-%m-%d")
      output = <<YAML
---
date_captured: "#{today}"
date_scanned: "#{today}"
camera: "rz67"
lens: 110
iso: 100
frames:
  - number: 1
    shutter: "1/125"
    aperture: 8
  - number: 2
    shutter: "1/125"
    aperture: 8
  - number: 3
    shutter: "1/125"
    aperture: 8
  - number: 4
    shutter: "1/125"
    aperture: 8
  - number: 5
    shutter: "1/125"
    aperture: 8
  - number: 6
    shutter: "1/125"
    aperture: 8
  - number: 7
    shutter: "1/125"
    aperture: 8
  - number: 8
    shutter: "1/125"
    aperture: 8
  - number: 9
    shutter: "1/125"
    aperture: 8
  - number: 10
    shutter: "1/125"
    aperture: 8
YAML
    end

  end
end
