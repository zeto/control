require 'rake'
require 'rake/testtask'

task :default => [:test_units]

desc "Run basic tests"
Rake::TestTask.new("test_units") { |t|
  t.pattern = 'test/lib/control/*_test.rb'
  t.verbose = false
  t.warning = false
}

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r control.rb"
end
