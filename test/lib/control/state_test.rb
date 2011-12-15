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
  
  def test_state_change_complies_with_defined_next_states
    p = Product.new
    
    validate = Validate.new
    validate.product = p
    validate.save
    
    assembly = Assembly.new
    assembly.product = p
    
    assert_raise Control::InvalidTransition do
      assembly.save  
    end
  end
  
  def test_previous_state
    p = Product.new
    p.save
    
    assembly = Assembly.new
    assembly.product = p
    assembly.save
    
    validate = Validate.new
    validate.product = p
    validate.save

    assert assembly.previous.nil?
    assert validate.previous == assembly
  end
  
  def test_next_state
    p = Product.new
    p.save
    
    assembly = Assembly.new
    assembly.product = p
    assembly.save
    
    validate = Validate.new
    validate.product = p
    validate.save

    assert assembly.next == validate
    assert validate.next.nil?
  end
  
end
