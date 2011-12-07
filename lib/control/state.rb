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
      super
      
      if is_part_of_workflow?
        workflow.current_state = self
        
        # save transition
        
      end
    end
    
    def is_part_of_workflow?
      true
    end
    
    def workflow
      # really bad solution, but works
      self.class.reflect_on_all_associations.each.map do |a|
        possible_workflow_object = self.send a.name
        
        if possible_workflow_object.class.respond_to?('is_workflow?') && possible_workflow_object.class.is_workflow?
          return possible_workflow_object
        end
      end
    end
  end
end
