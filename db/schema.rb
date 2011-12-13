ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Schema.define(:version => 1) do

  create_table :transitions do |t|
    t.string  :workflow
    t.integer :workflow_id
    t.string :from
    t.integer :from_id
    t.string :to
    t.integer :to_id
    t.timestamps
  end

end
