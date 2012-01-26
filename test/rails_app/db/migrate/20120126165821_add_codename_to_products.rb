class AddCodenameToProducts < ActiveRecord::Migration
  def change
    add_column :products, :codename, :string

  end
end
