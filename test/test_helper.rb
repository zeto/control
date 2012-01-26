require 'active_record'
require 'turn'

require 'control'
require 'test/unit'

require './test/test_schema'
require './db/migrate/create_transitions'




#                   Product
#                      |
#      ----------------------------------
#      |          |          |          | 
#  Assembly ->  Validate -> Box       Reject
#                 |                     ^
#                 |                     |
#                 -----------------------

CreateTransitions.up

class Product < ActiveRecord::Base
  include Control::Workflow
  has_many :assemblies
  has_many :validates
  has_many :boxes
  has_many :rejects
end

class Assembly < ActiveRecord::Base
	include Control::State
	
  belongs_to :product
  next_states :validate
end

class Validate < ActiveRecord::Base
  include Control::State

  belongs_to :product
  next_states :box, :reject
end

class Box < ActiveRecord::Base
  include Control::State

  belongs_to :product
end

class Reject < ActiveRecord::Base
  include Control::State

  belongs_to :product
end

class WorkflowlessState < ActiveRecord::Base
  include Control::State
  
  next_states :validate
end
