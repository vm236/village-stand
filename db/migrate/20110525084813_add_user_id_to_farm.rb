class AddUserIdToFarm < ActiveRecord::Migration
  def self.up
    add_column :farms, :user_id, :integer
  end

  def self.down
    remove_column :farms, :user_id
  end
end
