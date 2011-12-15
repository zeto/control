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
          @next_states.map { |s| Kernel.const_get(s) } if @next_states
        end
      end
      
      def is_state?
        true
      end
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
    
    def previous
      transition = workflow.transitions.where(:to_class => self.class, :to_id => self.id).first
      Kernel.const_get(transition.from_class).find(transition.from_id) if transition && !transition.from_class.blank?
    end
    
    def next
      transition = workflow.transitions.where(:from_class => self.class, :from_id => self.id).first
      Kernel.const_get(transition.to_class).find(transition.to_id) if transition
    end
    
    private
    
    def validate_transition
      raise Control::NoAssociationToWorkflow unless is_part_of_workflow?
      raise Control::WorkflowDisabled unless workflow.enabled
      raise Control::InvalidTransition unless workflow_initial_state_or_valid_next_state
    end
    
    def is_part_of_workflow?
      !!workflow
    end
    
    def next_state_is_valid
      workflow.current_state && ((workflow.current_state.class.next_states && (workflow.current_state.class.next_states.any? && (workflow.current_state.class.next_states.include? self.class))) || !workflow.current_state.class.next_states)
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
      puts transition.errors.each {|e| puts e}                   
    end 
    
  end
end
