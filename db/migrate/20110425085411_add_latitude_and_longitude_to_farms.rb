class AddLatitudeAndLongitudeToFarms < ActiveRecord::Migration
  def self.up
    add_column :farms, :latitude, :float
    add_column :farms, :longitude, :float
    add_column :farms, :address, :string
  end

  def self.down
    remove_column :farms, :longitude
    remove_column :farms, :latitude
    remove_column :farms, :address
  end
end
