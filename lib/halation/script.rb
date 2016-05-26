require 'optparse'

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

      options = {}

      OptionParser.new { |opts|
        opts.banner = "Usage: halation [options]"

        opts.on("-c", "--config=PATH", String, "Config file path") do |config_path|
          options[:config_path] = config_path
          p config_path
        end

        opts.on("--dry", "Dry run") do
          options[:dry] = true
        end

        opts.on("-h", "--help", "Print this help") do
          output_stream.puts opts
          exit unless skip_exit
        end

        opts.on("--generate-config", "Generate a new config file") do |path|
          # TODO: Implement
          raise NotImplementedError
          exit unless skip_exit
        end

        opts.on("-p", "--print-config", "Print the configuration settings") do
          # TODO: Implement
          raise NotImplementedError
          exit unless skip_exit
        end

        opts.on("-r", "--recursive", "Traverse into subdirectories") do
          # TODO: Implement
          raise NotImplementedError
        end

        opts.on("-v", "--version", "Print the version information") do
          output_stream.puts "halation #{Halation::VERSION}"
          exit unless skip_exit
        end
      }.parse!(args)
    end

  end
end
