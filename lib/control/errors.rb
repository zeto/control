module Control
  class ControlError < StandardError
  end
  
  # Raise when user tries to save a state, 
  # and the current state does not allow the transition, defined with next_states
  class InvalidTransition < ControlError
  end
  
  class WorkflowDisabled < ControlError
  end
  
  class NoAssociationToWorkflow < ControlError
  end
  
end
