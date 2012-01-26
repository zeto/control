class CreateRejects < ActiveRecord::Migration
  def change
    create_table :rejects do |t|
      t.integer :product_id

      t.timestamps
    end
  end
end
