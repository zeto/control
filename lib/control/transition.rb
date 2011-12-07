require 'active_record'

module Control
  class Transition < ActiveRecord::Base
    def to_s
      "Workflow: #{workflow} || #{created_at} #{from} -> #{to}"
    end
  end  
end
