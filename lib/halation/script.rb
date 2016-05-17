require 'optparse'

module Halation
  # The script that runs when the halation binary is executed.
  class Script
    private_class_method :new

    # Parses ARGV.
    def self.run(args = ARGV, output_stream = STDOUT)
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
          exit
        end

        opts.on("-p", "--print-config", "Print the configuration settings") do
          # TODO: Implement
          raise NotImplementedError
          exit
        end

        opts.on("-r", "--recursive", "Traverse into subdirectories") do
          # TODO: Implement
          raise NotImplementedError
          exit
        end

        opts.on("-v", "--version", "Print the version information") do
          output_stream.puts "halation #{Halation::VERSION}"
          exit
        end

      }.parse!(args)
    end

  end
end
