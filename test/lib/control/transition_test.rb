require(File.expand_path(File.join('.','test/test_helper')))

class TransitionTest < Test::Unit::TestCase  
  def test_after_state_save_transition_must_be_saved
    p = Product.new
    p.save
  
    assert Control::Transition.all.count == 0
  
    a = Assembly.new
    a.product = p
    a.save
    
    assert Control::Transition.all.count == 1
    assert Control::Transition.where(:workflow => 'Product').first.to == 'Assembly'
    
    v = Validate.new
    v.product = p
    v.save
    
    assert Control::Transition.all.count == 2
    assert Control::Transition.where(:workflow => 'Product').last.from == 'Assembly'
    assert Control::Transition.where(:workflow => 'Product').last.to == 'Validate'
  end

end
