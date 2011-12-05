module Control
  module State
  
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
  end
end
