require 'active_record'

module Control
  class Transition < ActiveRecord::Base
    validates :workflow_class, :presence => true
    validates :workflow_id, :presence => true
    validates :to_class, :presence => true
    validates :to_id, :presence => true
    validates :from_id, :presence => true, :if => "!from_class.nil?"
    validate :validate_classes
    
    def validate_classes
      Kernel.const_get(workflow_class) rescue errors.add(:workflow_class,'invalid workflow')
      Kernel.const_get(to_class) rescue errors.add(:to_class,'invalid to')
      Kernel.const_get(from_class) if !from_class.blank? rescue errors.add(:from_class,'invalid from')
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
      Kernel.const_get(from_class).find(from_id) if !from_class.blank?
    end
  end  
end
