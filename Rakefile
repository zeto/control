require 'rake'
require 'rake/testtask'

task :default => [:test_units]

desc "Run tests"
Rake::TestTask.new("test_units") { |t|
  puts "RUNNING TESTS YAY"
  
  t.pattern = 'test/lib/control/*_test.rb'
  t.verbose = true
  t.warning = false
}

desc "Open an irb session"
task :console do
  sh "irb -rubygems -I lib -r control.rb"
end
