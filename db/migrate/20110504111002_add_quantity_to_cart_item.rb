class AddQuantityToCartItem < ActiveRecord::Migration
  def self.up
    add_column :cart_items, :quantity, :integer, :default => 1
  end

  def self.down
    remove_column :cart_items, :quantity
  end
end
