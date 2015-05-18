$:.unshift File.expand_path('../lib', __FILE__)

require 'rfunk/version'

Gem::Specification.new do |s|
  s.name = 'rfunk'
  s.version = RFunk::VERSION
  s.authors = ['Alex Falkowski']
  s.email = ['alexrfalkowski@gmail.com']
  s.homepage = 'https://github.com/alexfalkowski/rfunk'
  s.summary = 'Functional Programming in Ruby'
  s.description = 'See https://github.com/alexfalkowski/rfunk/blob/master/README.md'
  s.license = 'MIT'

  s.files = `git ls-files lib`.split("\n")
  s.platform = Gem::Platform::RUBY
  s.require_paths = ['lib']

  s.add_dependency 'ice_nine', '~> 0.11.0'
  s.add_dependency 'concurrent-ruby', '~> 0.7.0'
  s.add_dependency 'hamster', '~> 0.4.3'

  s.add_development_dependency 'rake', '~> 10.4.2'
  s.add_development_dependency 'rspec', '~> 2.14.1'
  s.add_development_dependency 'rspec-given', '~> 3.5.4'
end
