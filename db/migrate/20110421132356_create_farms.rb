class CreateFarms < ActiveRecord::Migration
  def self.up
    create_table :farms do |t|
      t.string :name
      t.integer :harvest
      t.string :offers
      t.text :about

      t.timestamps
    end
  end

  def self.down
    drop_table :farms
  end
end
