class CreateFarmProducts < ActiveRecord::Migration
  def self.up
    create_table :farm_products do |t|
      t.integer :farm_id
      t.integer :product_id
      t.integer :harvest
      t.decimal :price
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :farm_products
  end
end
