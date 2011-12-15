require(File.expand_path(File.join('.','test/test_helper')))

class TransitionTest < Test::Unit::TestCase  
  def test_after_state_save_transition_must_be_saved
    p = Product.new
    p.save
  
    assert p.transitions.count == 0
  
    a = Assembly.new
    a.product = p
    a.save
    
    assert p.transitions.count == 1
    assert p.transitions.first.to_class == Assembly.to_s
    assert p.transitions.first.created_at < Time.current
    
    v = Validate.new
    v.product = p
    v.save
    
    assert p.transitions.count == 2
    assert p.transitions.last.from_class == Assembly.to_s
    assert p.transitions.last.to_class == Validate.to_s
    assert p.transitions.first.created_at < p.transitions.last.created_at
  end
  
  def test_correct_class_names
    t = Control::Transition.new
    t.workflow_class = Product.to_s
    t.workflow_id = 1
    t.from_class = Validate.to_s
    t.from_id = 1
    t.to_class = Assembly.to_s
    t.to_id = 1
    
    assert t.valid?
  end
  
  def test_empty_transition
    t = Control::Transition.new
    assert !t.valid?
  end
  
  def test_incorrect_workflow
    t = Control::Transition.new
    t.workflow_class = "Prudoct"
    t.workflow_id = 1
    t.from_class = Validate.to_s
    t.from_id = 1
    t.to_class = Assembly.to_s
    t.to_id = 1
    
    assert !t.valid?
  end
  
  def test_incorrect_from
    t = Control::Transition.new
    t.workflow_class = Product.to_s
    t.workflow_id = 1
    t.from_class = 'Valideta'
    t.from_id = 1
    t.to_class = Assembly.to_s
    t.to_id = 1
    
    assert !t.valid?
  end
  
  def test_incorrect_to
    t = Control::Transition.new
    t.workflow_class = Product.to_s
    t.workflow_id = 1
    t.from_class = Validate.to_s
    t.from_id = 1
    t.to_class = 'Assembli'
    t.to_id = 1
    
    assert !t.valid?
  end
end
