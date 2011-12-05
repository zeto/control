require(File.expand_path(File.join('.','test/test_helper')))

class WorkflowTest < Test::Unit::TestCase
  def test_workflow_is_enabled_by_default
    assert Product.new.enabled
  end
  
  def test_state_list
    assert Product.new.states.count == 4
    assert Product.new.states.include?(Box)
    assert Product.new.states.include?(Assembly)
    assert Product.new.states.include?(Reject)
    assert Product.new.states.include?(Validate)
  end
  
  def 
  end
end
