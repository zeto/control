class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :ribbon_color
      t.integer :product_id

      t.timestamps
    end
  end
end
