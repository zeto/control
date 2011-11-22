require 'test_helper'

class WorkflowTest < ActiveSupport::TestCase
  test 'Workflow is enabled by default' do
    assert_true Workflow.new.enabled?
  end
end
