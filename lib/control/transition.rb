require 'active_record'

module Control
  class Transition < ActiveRecord::Base
    validate_presence_of :workflow
    validate_presence_of :workflow_id
    validate_presence_of :to
    validate_presence_of :to_id
    
    def to_s
      "Workflow: #{workflow} || #{created_at} #{from} -> #{to}"
    end
  end  
end
