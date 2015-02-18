$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'filter_decrufter/version'

Gem::Specification.new do |s|
  
  s.name = 'filter_decrufter'
  s.version = FilterDecrufter::VERSION
  s.email = "tom@thomasleecopeland.com"
  s.homepage = "https://github.com/tcopeland/filter_decrufter"
  s.summary = "Finds cruft in Rails filters"
  s.description = "Finds old action symbols in Rails before / after / around filters"
  s.license = 'MIT'
  s.authors = ['Tom Copeland']
  s.rubyforge_project = 'none'
  s.files = Dir['lib/**/*', '*\.md', 'doc/**/*']
  s.bindir = 'bin'
  s.require_paths = ['lib']
  s.add_development_dependency 'rake', '~> 10.1'
  s.add_development_dependency 'minitest', '~> 5.0'
  s.required_ruby_version = '>= 1.9.3'
  
end