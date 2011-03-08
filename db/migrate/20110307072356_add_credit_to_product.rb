class AddCreditToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :credit, :decimal
  end

  def self.down
    remove_column :products, :credit
  end
end
