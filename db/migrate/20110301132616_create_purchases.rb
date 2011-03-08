class CreatePurchases < ActiveRecord::Migration
  def self.up
    create_table :purchases do |t|
      t.integer :id
      t.integer :product_id
      t.integer :person_id
      t.text    :serial_number
      t.timestamps
    end
  end

  def self.down
    drop_table :purchases
  end
end
