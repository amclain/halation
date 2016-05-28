require 'optparse'

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

      OptionParser.new { |opts|
        opts.banner = "Usage: halation [options]"

        opts.on("-c", "--config=PATH", String, "Config file path") do |config_path|
          options[:config_path] = config_path
        end

        opts.on("--dry", "Dry run") do
          options[:dry_run] = true
          # TODO: Implement
          raise NotImplementedError, "Dry run option is not yet implemented."
        end

        opts.on("-h", "--help", "Print this help") do
          output_stream.puts opts
          run_engine = false
          exit unless skip_exit
        end

        opts.on("--new-config", "Generate a new config file") do |path|
          # TODO: Implement
          raise NotImplementedError, "Generate config option is not yet implemented."
          run_engine = false
          exit unless skip_exit
        end

        opts.on("--new-roll", "Generate a new roll.yml file") do
          # TODO: Implement
          raise NotImplementedError, "Generate roll option is not yet implemented."
          run_engine = false
          exit unless skip_exit
        end

        opts.on("-p", "--print-config", "Print the configuration settings") do
          # TODO: Implement
          raise NotImplementedError, "Print config option is not yet implemented."
          run_engine = false
          exit unless skip_exit
        end

        opts.on("-r", "--recursive", "Traverse into subdirectories") do
          # TODO: Implement
          raise NotImplementedError, "Recursive option is not yet implemented."
        end

        opts.on("--silent", "Suppress messages to stdout.") do
          options[:silent] = true
        end

        opts.on("-v", "--version", "Print the version information") do
          output_stream.puts "halation #{Halation::VERSION}"
          run_engine = false
          exit unless skip_exit
        end
      }.parse!(args)
      
      Halation::Engine.run(options) if run_engine
    end

  end
end
