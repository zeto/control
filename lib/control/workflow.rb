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

    attr_accessor :current_state
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
      # really bad solution, but is executed only once per object
      self.class.reflect_on_all_associations.each.map do |a|
        klass = Kernel.const_get(a.name.to_s.classify)
        
        if klass.respond_to?('is_state?') && klass.is_state?
          klass
        end
      end
    end
  end
end
