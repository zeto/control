module Control
  class ControlError < StandardError
  end
  
  class InvalidTransition < ControlError
  end
  
  class WorkflowDisabled < ControlError
  end
end
