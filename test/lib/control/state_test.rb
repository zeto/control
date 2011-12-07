require(File.expand_path(File.join('.','test/test_helper')))

class StateTest < Test::Unit::TestCase
  def test_state_can_define_next_states
    assert Box.respond_to? 'next_states'
  end
  
  def test_correct_next_states
    assert Validate.next_states.include?(Box)
    assert Validate.next_states.include?(Reject)
    assert !Validate.next_states.include?(Validate)
    assert !Validate.next_states.include?(Assembly)
  end
  
  def test_infer_workflow_to_which_i_belong
    p = Product.new
    
    box = Box.new
    box.product = p
    
    assert box.workflow
    assert box.workflow == box.product
    assert Product == box.workflow.class
  end
  
end
