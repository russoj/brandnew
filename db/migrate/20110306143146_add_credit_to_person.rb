class AddCreditToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :credit, :decimal
  end

  def self.down
    remove_column :people, :credit
  end
end
