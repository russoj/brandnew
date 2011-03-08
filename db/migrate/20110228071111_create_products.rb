class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.integer :id
      t.integer :brand_id
      t.string :name
      t.text :description
      t.string :filename
      t.string :thumbnail
      t.string :content_type
      t.integer :size
      t.integer :width
      t.integer :height
      t.integer :parent_id
      t.timestamps
    end
  end


  def self.down
    drop_table :products
  end
end
