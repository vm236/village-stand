class AddVotesToFarms < ActiveRecord::Migration
  def self.up
    add_column :farms, :votes_count, :integer, :default => 0
  end

  def self.down
    remove_column :farms, :votes_count
  end
end
