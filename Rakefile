require 'rspec/core/rake_task'
require 'yard'

task :default => [:test, :check_docs]

desc "Run tests."
RSpec::Core::RakeTask.new :test do |c|
  # c.rspec_opts = 
  #   '--color '\
  #   '--format Fivemat '\
  #   # '--fail-fast'
end

desc "Build the gem."
task :build => [:doc] do
  Dir['*.gem'].each {|file| File.delete file}
  system 'gem build *.gemspec'
end

desc "Rebuild and [re]install the gem."
task :install => [:build] do
  system 'gem install *.gem'
end

desc "Generate documentation."
YARD::Rake::YardocTask.new :doc do |t|
  t.options = %w(- README.md LICENSE)
end

desc "Check for 100% documentation"
task :check_docs do
  output = ""

  puts "Generating documentation..."

  IO.popen("rake doc") do |f|
    f.each do |line|
      output += line
      puts line
    end
  end

  message = "\nChecking for 100% documentation..."

  if output =~ /\b100\.00% documented\b/
    puts "#{message} PASSED"
  else
    puts "#{message} FAIL"
    exit 1
  end
end
