class AddLogoToFarms < ActiveRecord::Migration
  def self.up
    add_column :farms, :logo, :string
  end

  def self.down
    remove_column :farms, :logo
  end
end
