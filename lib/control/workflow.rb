module Control
  module Workflow    
    
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def is_workflow?
        true
      end
      
      def states
        reflect_on_all_associations.each.map do |a|
          klass = Kernel.const_get(a.name.to_s.classify)
          if klass.respond_to?(:is_state?) and klass.is_state?
            klass
          end
        end
      end
    end
    
    def enabled
      true
    end

    def states
      self.class.states
    end

    def transitions
      Control::Transition.where(:workflow_class => self.class.name, :workflow_id => self.id)
    end
    
    alias :history :transitions
    
    def current_state
      transitions.last.to if transitions.last
    end 
  end
end
