require 'rake'
require 'rake/testtask'

task :default => [:test_units]

desc "Run basic tests"
Rake::TestTask.new("test_units") { |t|
  t.pattern = 'test/lib/control/*_test.rb'
  t.verbose = false
  t.warning = false
}
