class CreateLastActivities < ActiveRecord::Migration
  def self.up
    create_table :last_activities do |t|
      t.string :message
      t.timestamps
    end
  end

  def self.down
    drop_table :last_activities
  end
end
