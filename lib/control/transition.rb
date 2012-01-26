module Control
  class Transition < ActiveRecord::Base
    validates :workflow_class, :presence => true
    validates :workflow_id, :presence => true
    validates :to_class, :presence => true
    validates :to_id, :presence => true
    validates :from_id, :presence => true, :if => "!from_class.nil?"
    validate :validate_classes
    validate :validate_objects
    
    def validate_classes
      Kernel.const_get(from_class) unless from_class.blank? rescue errors.add(:from_class,'invalid from')
      Kernel.const_get(to_class) rescue errors.add(:to_class,'invalid to')
      Kernel.const_get(workflow_class) rescue errors.add(:workflow_class,'invalid workflow')
    end
    
    def validate_objects
    	from rescue errors.add(:workflow,'invalid from')
    	to rescue errors.add(:to,'invalid to')
    	workflow rescue errors.add(:workflow,'invalid workflow')
    end
    
    def to_s
      "Workflow: #{workflow_class} || #{created_at} #{from_class} -> #{to_class}"
    end
    
    def workflow
      Kernel.const_get(workflow_class).find(workflow_id)
    end
    
    def to
      Kernel.const_get(to_class).find(to_id)
    end
    
    def from
      Kernel.const_get(from_class).find(from_id) unless from_class.blank?
    end
  end  
end
