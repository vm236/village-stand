class AddExpMonthAndExpYearToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :exp_month, :integer
    add_column :orders, :exp_year, :integer
  end

  def self.down
    remove_column :orders, :exp_month
    remove_column :orders, :exp_year
  end
end
