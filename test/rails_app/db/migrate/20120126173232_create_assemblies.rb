class CreateAssemblies < ActiveRecord::Migration
  def change
    create_table :assemblies do |t|
      t.string :assembler
      t.integer :product_id

      t.timestamps
    end
  end
end
