require 'rubygems'
require 'bundler'
require 'rake'
require 'jeweler'
require 'rspec/core/rake_task'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end

Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = 'rfunk'
  gem.homepage = 'http://github.com/alexfalkowski/rfunk'
  gem.license = 'MIT'
  gem.summary = 'Functional Programming in Ruby'
  gem.description = 'https://github.com/alexfalkowski/rfunk/blob/master/README.md'
  gem.email = 'alexrfalkowski@gmail.com'
  gem.authors = ['Alex Falkowski']
  gem.add_dependency 'ice_nine'
end

Jeweler::RubygemsDotOrgTasks.new

RSpec::Core::RakeTask.new(:spec)

task :default => :spec