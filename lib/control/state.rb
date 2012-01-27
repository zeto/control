module Control
  module State

    def self.included(base)
      base.extend(ClassMethods)
      base.send :before_save, :validate_transition
      base.send :after_save, :save_transition
    end
  
    module ClassMethods
      def next_states(*states)
        if states && states.count > 0
          if states.first == :none
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

      def final?
        !!@final
      end
      
      def is_state?
        true
      end
      
      def workflow_class
        unless @workflow_class
          reflect_on_all_associations.each do |a|
            klass = Kernel.const_get(a.name.to_s.classify)
            @workflow_class = klass if klass.respond_to?(:is_workflow?) && klass.is_workflow?
          end
        end
        @workflow_class
      end
    end 
    
    def workflow
      send self.class.workflow_class.to_s.underscore if self.class.workflow_class
    end
    
    def previous
      transition = workflow.transitions.where(:to_class => self.class, :to_id => self.id).first
      transition.from if transition
    end
    
    def next
      transition = workflow.transitions.where(:from_class => self.class, :from_id => self.id).first
      transition.to if transition
    end
    
    private
    
    def validate_transition
      raise Control::NoAssociationToWorkflow unless is_part_of_workflow?
      raise Control::WorkflowDisabled unless workflow.enabled
      raise Control::InvalidTransition unless workflow_initial_state_or_valid_next_state
      raise Control::FinalState if current_state_is_final?
    end
    
    def current_state_is_final?
      workflow.current_state && workflow.current_state.class.final?
    end

    def is_part_of_workflow?
      !!workflow
    end
    
    def next_state_is_valid
      workflow.current_state && ((workflow.current_state.class.next_states && (workflow.current_state.class.next_states.any? && (workflow.current_state.class.next_states.include? self.class))) || workflow.current_state.class.next_states.blank?)
    end
    
    def workflow_initial_state_or_valid_next_state
      !workflow.current_state || next_state_is_valid
    end
    
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
