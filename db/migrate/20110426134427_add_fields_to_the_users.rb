class AddFieldsToTheUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :users, :address, :string
    rename_column :users, :name, :username
  end

  def self.down
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :longitude
    remove_column :users, :latitude
    remove_column :users, :address
    rename_column :users, :username, :name
  end
end
