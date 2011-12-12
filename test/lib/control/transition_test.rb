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
    assert p.transitions.first.to == Assembly.to_s
    assert p.transitions.first.created_at < Time.current
    
    v = Validate.new
    v.product = p
    v.save
    
    assert p.transitions.count == 2
    assert p.transitions.last.from == Assembly.to_s
    assert p.transitions.last.to == Validate.to_s
    assert p.transitions.first.created_at < p.transitions.last.created_at
  end
end
