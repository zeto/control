module Control
  module Workflow    
    
    module ClassMethods
    end

    attr_reader :current_state
    attr_reader :enabled
    
    def initialize
      @enabled = true
    end
    
    def disable
      @enabled = false
    end

    def history
      puts 'the rest is history...'
    end

    def states
      puts 'list states'
    end
  end
end
