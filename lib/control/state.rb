module Control
  module State

    def self.included(base)
      base.extend(ClassMethods)
      base.send :before_save, :validate_transition
      base.send :after_save, :save_transition
    end
  
    module ClassMethods
      # Getter/setter for possible next_states
      # 
      # @param states state classes in underscore format. Can also use :none to mark state as final
      # @return [Array<State>] called with no parameters, an array is returned with next possible states
      def next_states(*states)
        if states && states.count > 0
          if states.include? :none
            @final = true
          else
            @next_states = []
            states.each do |s|
              klass_name = s.to_s.classify
              @next_states << klass_name if klass_name
            end
          end
        else
          if @final                                         # state is final, there are no possible next states
            Array.new
          else                                              # state is not final, carry on
            if @next_states                                 # possible next states were previously declared in class
              @next_states.map { |s| Kernel.const_get(s) }
            else                                            # all states connected to the workflow are valid, no constrains
              workflow_class.states
            end
          end
        end
      end           
      
      # Checks if class is a state
      # @return [Boolean] 
      def is_state?
        true
      end
      
      # Gets the workflow class associated with the state
      # @return [Class] workflow class object
      def workflow_class
        unless @workflow_class
          reflect_on_all_associations.each do |a|
            klass = Kernel.const_get(a.name.to_s.classify)
            @workflow_class = klass if klass.respond_to?(:is_workflow?) && klass.is_workflow?
          end
        end
        @workflow_class
      end

      # Checks if a state is final. There can be no transitions.
      # @return [Boolean]
      def final?
        !!@final
      end
    end 
    
    # Gets the workflow associated with state
    # @return workflow object
    def workflow
      send self.class.workflow_class.to_s.underscore if self.class.workflow_class
    end
    
    # Get previous state
    # @return previous state object
    def previous
      transition = workflow.transitions.where(:to_class => self.class, :to_id => self.id).first
      transition.from if transition
    end
    
    # Get the next state
    # @return next state object
    def next
      transition = workflow.transitions.where(:from_class => self.class, :from_id => self.id).first
      transition.to if transition
    end
    
    private
    
    # Validate requirements for transition. Will raise Exceptions if invalid
    #   - State must be associated with a workflow 
    #   - Associated workflow must be enabled
    #   - Either the first state is being saved, or the state being saved is defined in next_states
    #   - No transition can occur if the state is declared as final
    def validate_transition
      raise Control::NoAssociationToWorkflow unless is_part_of_workflow?
      raise Control::WorkflowDisabled unless workflow.enabled
      raise Control::InvalidTransition unless workflow_initial_state_or_valid_next_state
      raise Control::FinalState if current_state_is_final?
    end
    
    # Checks if current state is declared as final
    # @return [Boolean]
    def current_state_is_final?
      workflow.current_state && workflow.current_state.class.final?
    end

    # Checks if state is part of workflow. Defined with activerecord decorators.
    # @return [Boolean]
    def is_part_of_workflow?
      !!workflow
    end
    
    # Checks if state being saved is defined in next_states of current workflow state.
    # @return [Boolean]
    def next_state_is_valid
      workflow.current_state && ((workflow.current_state.class.next_states && (workflow.current_state.class.next_states.any? && (workflow.current_state.class.next_states.include? self.class))) || workflow.current_state.class.next_states.blank?)
    end
    
    # Checks if state is the first being saved or complies with defined next states
    # @return [Boolean]
    def workflow_initial_state_or_valid_next_state
      !workflow.current_state || next_state_is_valid
    end

    # Save a transition object
    # Runs after any successfully saved state, connects the previous and now current state
    def save_transition
      transition = Control::Transition.new do |t|
        t.workflow_class = workflow.class.name
        t.workflow_id = workflow.id
        if workflow.current_state
          t.from_class = workflow.current_state.class.name
          t.from_id = workflow.current_state.id
        end
        t.to_class = self.class.name
        t.to_id = id
      end
      transition.save             
    end 
    
  end
end
