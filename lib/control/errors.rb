module Control
  class ControlError < StandardError
  end
  
  # Raised when the current state does not allow the transition, defined with next_states
  class InvalidTransition < ControlError
  end
  
  class WorkflowDisabled < ControlError
  end
  
  # Raised when the state does not reference any workflow with 'belongs_to'
  class NoAssociationToWorkflow < ControlError
  end
  
  # Raised when the workflow is in a final state and is therefore blocked for any new transition
  class FinalState < ControlError
  end
  
end
