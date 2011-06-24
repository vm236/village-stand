class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :ship_address
      t.string :city
      t.string :state
      t.string :zip
      t.string :cc_number
      t.string :telephone
      t.integer :cart_id

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
