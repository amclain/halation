require_relative 'lib/halation/version'

Gem::Specification.new do |s|
  s.name        = 'halation'
  s.version     = Halation::VERSION
  s.date        = Time.now.strftime '%Y-%m-%d'
  s.summary     = 'Add Exif metadata to film photographs.'
  s.description = 'Add Exif metadata to film photographs.'

  s.homepage    = 'https://github.com/amclain/halation'
  s.authors     = ['Alex McLain']
  s.email       = ['alex@alexmclain.com']
  s.license     = 'MIT'

  s.files = [
      'LICENSE',
      'README.md',
    ] +
    Dir[
      'bin/**/*',
      'lib/**/*',
      'doc/**/*',
    ]

  s.executables = [
    'halation',
  ]

  s.add_dependency 'mini_exiftool', '~> 2.7', '>= 2.7.2'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rb-readline'
  s.add_development_dependency 'rspec', '~>3.4'
  s.add_development_dependency 'rspec-its', '~> 1.2'
  s.add_development_dependency 'fivemat'
end
