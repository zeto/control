require(File.expand_path(File.join('.','test/test_helper')))

# change to mocha, factory.. whatever
class Life < ActiveRecord::Base
  include Control::Workflow
end

class State < ActiveRecord::Base
  extend Control::State::ClassMethods
end

class Baby < State
	
  belongs_to :life
  next_states :some_other_state
end

class Teenager < State
  belongs_to :life
end

class WorkflowTest < Test::Unit::TestCase
  def test_workflow_is_enabled_by_default
    assert Life.new.enabled
  end
  
  def test_treta
  	life = Life.new
  	baby = Baby.new
  	#baby.life = life
  	
  	#assert babe.life.enabled
  end
end
