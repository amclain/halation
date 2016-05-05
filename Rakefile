require 'rspec/core/rake_task'
require 'yard'

task :default => [:test]

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
