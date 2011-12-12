module Control
  module State
  
    def self.included(base)
      base.extend(ClassMethods)
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
    
    def initialize
      super
    end
    
    def save
      if workflow.enabled
        if true #workflow.current_state.class.next_states.include? self.class
          if super
            if is_part_of_workflow?
              # save transition
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
              
              workflow.current_state = self
            end
          end
        else
          raise Control::InvalidTransition
        end
      else
        raise Control::WorkflowDisabled
      end
    end
    
    def is_part_of_workflow?
      !!workflow
    end
    
    def workflow
      self.class.reflect_on_all_associations.each do |a|
        possible_workflow_object = self.send a.name
        
        if possible_workflow_object.class.respond_to?('is_workflow?') && possible_workflow_object.class.is_workflow?
          return possible_workflow_object
        end
      end
    end
  end
end
