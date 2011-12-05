require(File.expand_path(File.join('.','test/test_helper')))

class StateTest < Test::Unit::TestCase
  def test_state_can_define_next_states
    assert Box.respond_to? 'next_states'
  end
  
  def test_correct_next_states
    assert Validate.next_states
  end
end
