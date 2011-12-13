class CreateTransitions < ActiveRecord::Migration
  def self.up
    create_table(:transitions) do |t|
      t.string  :workflow
      t.integer :workflow_id
      t.string :from
      t.integer :from_id
      t.string :to
      t.integer :to_id
      t.timestamps  
    end      
  end

  def self.down
    drop_table :transitions
  end  
  
end
