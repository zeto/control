require 'active_record'

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
          @next_states = []
          states.each do |s|
            klass_name = s.to_s.classify
            @next_states << klass_name if klass_name
          end
        else
          @next_states.map { |s| Kernel.const_get(s) }
        end
      end
      
      def is_state?
        true
      end
    end
    
    def validate_transition
      raise Control::NoAssociationToWorkflow unless is_part_of_workflow?
      raise Control::WorkflowDisabled unless workflow.enabled
      raise Control::InvalidTransition unless workflow_initial_state_or_valid_next_state
    end  
    
    def workflow
      unless @workflow
        self.class.reflect_on_all_associations.each do |a|
          klass = Kernel.const_get(a.name.to_s.classify)
          @workflow = a.name if klass.respond_to?('is_workflow?') && klass.is_workflow?
        end
      end
      send @workflow if @workflow
    end
    
    private
    
    def is_part_of_workflow?
      !!workflow
    end
    
    def next_state_is_valid
      workflow.current_state && (workflow.current_state.class.next_states && (workflow.current_state.class.next_states.any? && (workflow.current_state.class.next_states.include? self.class)))
    end
    
    def workflow_initial_state_or_valid_next_state
      !workflow.current_state || next_state_is_valid
    end    
    
    def save_transition
      transition = Control::Transition.new do |t|
        t.workflow = workflow.class.name
        t.workflow_id = workflow.id
        if workflow.current_state
          t.from = workflow.current_state.class.name
          t.from_id = workflow.current_state.id
        end
        t.to = self.class.name
        t.to_id = id
      end
      transition.save                       
    end 
    
  end
end
