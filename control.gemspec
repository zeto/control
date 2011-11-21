Gem::Specification.new do |s|
  s.name        = 'control'
  s.version     = '0.0.0'
  s.date        = '2011-11-21'
  s.summary     = "Business Workflow State Machine"
  s.description = "A easy-to-use State Machine that integrates with ActiveRecord"
  s.authors     = ["Jose Goncalves"]
  s.email       = 'zetoeu@gmail.com'
  s.files       = ["lib/control.rb"]
  s.homepage    = 'http://rubygems.org/gems/control'
  s.add_dependency('activerecord','>= 3.1.0')
end
