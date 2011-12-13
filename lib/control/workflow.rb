module Control
  module Workflow    
    
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def is_workflow?
        true
      end
    end
    
    def initialize
      super
      @enabled = true
    end
    
    def enabled
      true
    end

    def transitions
      Control::Transition.where(:workflow => self.class.name, :workflow_id => self.id)
    end
    
    alias :history :transitions

    def states
      self.class.reflect_on_all_associations.each.map do |a|
        klass = Kernel.const_get(a.name.to_s.classify)
        
        if klass.respond_to?('is_state?') and klass.is_state?
          klass
        end
      end
    end
    
    def current_state
      if transitions.last
        Kernel.const_get(transitions.last.to).find(transitions.last.to_id)
      end
    end
    
  end
end
