require(File.expand_path(File.join('.','test/test_helper')))

# change to mocha, factory.. whatever
class Life
  include Control::Workflow
end

class State < ActiveRecord::Base
  extend Control::State::ClassMethods
end

class StateOne < State
  next_states :some_other_state
end

class StateTwo < State
  belongs_to :life
end

class WorkflowTest < Test::Unit::TestCase
  def test_workflow_is_enabled_by_default
    assert Life.new.enabled
  end
end
