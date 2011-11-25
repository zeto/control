#require '/home/xpita09/code/control/test/test_helper'
require(File.expand_path(File.join("test_helper")))


# change to mocha, factory.. whatever
class Life
  include Control::Workflow
end

class State < ActiveRecord::Base
  
end

class StateTwo < State
  belongs_to :life
end


class WorkflowTest < ActiveSupport::TestCase
  test 'Workflow is enabled by default' do
    assert Life.new.enabled
  end
  
  test 'State can define next states' do
    begin
      class StateTest
        next_states :some_other_state
      end
    rescue
      assert false
    end
    
    assert true
  end
end
