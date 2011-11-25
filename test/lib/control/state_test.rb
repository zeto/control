require(File.expand_path(File.join('.','test/test_helper')))

class StateTest < Test::Unit::TestCase
  def test_state_can_define_next_states
    assert State.respond_to? 'next_states'
  end
end
