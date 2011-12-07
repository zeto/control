$LOAD_PATH << File.expand_path( File.dirname(__FILE__) + '/../lib' )

require 'test/unit'
require 'turn'
require 'active_support'
require 'active_record'
require 'active_support/core_ext/object'
require 'control'


ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  
  create_table :transitions do |t|
    t.timestamps
  end
  
  create_table :products do |t|
    t.timestamps
  end
  
  create_table :assemblies do |t|
    t.integer :product_id
    t.timestamps
  end
  
  create_table :validates do |t|
    t.integer :product_id
    t.timestamps
  end
  
  create_table :boxes do |t|
    t.integer :product_id
    t.timestamps
  end
  
  create_table :rejects do |t|
    t.integer :product_id
    t.timestamps
  end
end

#                   Product
#                      |
#      ----------------------------------
#      |          |          |          | 
#  Assembly ->  Validate -> Box       Reject
#                 |                     ^
#                 |                     |
#                 -----------------------

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
  next_states :test
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
