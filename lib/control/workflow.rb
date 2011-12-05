module Control
  module Workflow    
    
    module ClassMethods
    end

    attr_reader :current_state
    attr_reader :enabled
    
    def initialize
      super
      @enabled = true
    end
    
    def disable
      @enabled = false
    end

    def history
      puts 'the rest is history...'
    end

    def states
      self.class.reflect_on_all_associations.each.map do |a|
        klass = Kernel.const_get(a.name.to_s.classify)
        
        if klass.respond_to? 'is_state?'
          klass
        end
      end
    end
  end
end
