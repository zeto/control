Gem::Specification.new do |s|
  s.name        = 'control'
  s.version     = '0.9.0'
  s.date        = '2012-08-07'
  s.summary     = "Workflow State Machine"
  s.description = "State Machine integrated with ActiveRecord"
  s.authors     = ["Jose Goncalves"]
  s.email       = 'zetoeu@gmail.com'
  s.files       = ["lib/control.rb"]
  s.homepage    = 'http://rubygems.org/gems/control'

  s.require_paths = ["lib"]  
  s.add_dependency('activerecord','>= 3.0.0')
  s.add_dependency('activesupport','>= 3.0.0')
  s.add_development_dependency "sqlite3-ruby"
  s.add_development_dependency "turn"
end
