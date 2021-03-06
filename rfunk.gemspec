$LOAD_PATH.unshift File.expand_path('lib', __dir__)

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
  s.required_ruby_version = ['>= 2.7.0', '< 2.8.0']

  s.add_dependency 'concurrent-ruby', '~> 1.1', '>= 1.1.7'
  s.add_dependency 'hamster', '~> 3.0'
  s.add_dependency 'ice_nine', '~> 0.11.2'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-given'
  s.add_development_dependency 'rspec_junit_formatter'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'simplecov'
end
