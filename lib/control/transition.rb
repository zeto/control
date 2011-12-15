require 'active_record'

module Control
  class Transition < ActiveRecord::Base
    validates :workflow, :presence => true
    validates :workflow_id, :presence => true
    validates :to, :presence => true
    validates :to_id, :presence => true
    validates :from_id, :presence => true, :if => "!from.nil?"
    validate :validate_classes
    
    def validate_classes
      if !Kernel.const_get(workflow)
        errors.add(:workflow,'workflow class does not exist')
      end
      if !Kernel.const_get(to)
        errors.add(:to,'to class does not exist')
      end
      if !from.blank? && !Kernel.const_get(from)
        errors.add(:from,'from class does not exist')
      end
    end
    
    def to_s
      "Workflow: #{workflow} || #{created_at} #{from} -> #{to}"
    end
  end  
end
