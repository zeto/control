$LOAD_PATH << File.expand_path( File.dirname(__FILE__) + '/../lib' )

require 'test/unit'
require 'turn'
require 'active_support'
require 'active_record'

require 'control'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", 
                                       :database => File.dirname(__FILE__) + "/test.sqlite3")

#require File.dirname(__FILE__) + "/factories"
