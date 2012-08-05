module Control
  module Workflow    
    
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      # Checks if class is a workflow
      def is_workflow?
        true
      end
      
      # Get all state classes associated to this workflow
      # @return [Array<Class>]
      def states
        reflect_on_all_associations.each.map do |a|
          klass = Kernel.qualified_const_get(a.class_name.to_s.classify)
          if klass.respond_to?(:is_state?) and klass.is_state?
            klass
          end
        end
      end
    end
    
    # Checks if workflow is enabled
    # @return [Boolean]
    def enabled
      true
    end

    # Get all state classes associated to this workflow
    # @return [Array<Class>]
    def states
      self.class.states
    end

    # Get all transitions.
    # @return [Array<Transition>]
    def transitions
      Control::Transition.where(:workflow_class => self.class.name, :workflow_id => self.id)
    end
    
    alias :history :transitions
    
    # Get workflow current state
    # @return the state object
    def current_state
      transitions.last.to if transitions.last
    end 
  end
end
