require "rake/testtask"
require "rubygems"
require "bundler/setup"

Rake::TestTask.new do |t|
  t.name = "test:units"
  t.description = "Run unit tests"
  t.libs << "test"
  t.pattern = 'test/unit/**_test.rb'
end

Rake::TestTask.new do |t|
  t.name = "test:integration"
  t.description = "Run integration tests"
  t.libs << "test"
  t.pattern = 'test/integration/**_test.rb'
end

task :default => ["test:units", "test:integration"]