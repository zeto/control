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
      Kernel.const_get(workflow) rescue errors.add(:workflow,'invalid workflow')
      Kernel.const_get(to) rescue errors.add(:to,'invalid to')
      Kernel.const_get(from) if !from.blank? rescue errors.add(:from,'invalid from')
    end
    
    def to_s
      "Workflow: #{workflow} || #{created_at} #{from} -> #{to}"
    end
  end  
end
