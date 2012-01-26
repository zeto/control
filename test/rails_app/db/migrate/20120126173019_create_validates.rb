class CreateValidates < ActiveRecord::Migration
  def change
    create_table :validates do |t|
      t.boolean :standing_test
      t.boolean :sitting_test
      t.boolean :fat_guy_test
      t.boolean :evel_knievel_jumping_test
      t.string :tester
      t.integer :product_id

      t.timestamps
    end
  end
end
