ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:", :pool => 1)
ActiveRecord::Schema.define(:version => 1) do
  
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
  
  create_table :workflowless_states do |t|
    t.timestamps
  end
    
end
