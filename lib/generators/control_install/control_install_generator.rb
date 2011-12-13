require 'rails/generators'
require 'rails/generators/migration'

class ControlInstallGenerator < Rails::Generators::Base

  include Rails::Generators::Migration
  source_root File.expand_path('../../../../', __FILE__)
  
  def self.next_migration_number(path)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end  
  
  def migration
    unless transitions_table_exists? # SOURCE -> DESTINATION
      migration_template "db/migrate/create_transitions.rb", "db/migrate/create_transitions.rb"
    end
  end  
  
  def transitions_table_exists?
    ActiveRecord::Base.connection.table_exists?(:transitions)
  end  
end
