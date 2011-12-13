require(File.expand_path(File.join('.','test/test_helper')))

class WorkflowTest < Test::Unit::TestCase


  def test_state_belongs_to_workflow
    p = Product.new
    p.save
  
    a = Assembly.new
    a.product = p       
    
    assert_nothing_raised Control::NoAssociationToWorkflow do
      a.save   
    end 
  end
  
  def test_state_does_not_belongs_to_workflow
    workflowless_state = WorkflowlessState.new
    assert_raise Control::NoAssociationToWorkflow do
      workflowless_state.save   
    end 
  end  

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
  
  def test_initially_current_state_is_not_defined
    assert Product.new.current_state == nil
  end
  
  def test_after_transition_current_state_must_change
    p = Product.new
    p.save
  
    a = Assembly.new
    a.product = p
    a.save
        
    assert p.current_state == a
    
    v = Validate.new
    v.product = p
    v.save
    
    assert p.current_state == v
  end

end
