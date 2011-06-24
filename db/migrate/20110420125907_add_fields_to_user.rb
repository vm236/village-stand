class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :string, :default => 'user'
    add_column :users, :name, :string
  end

  def self.down
    remove_column :users, :role
    remove_column :users, :name
  end
end
