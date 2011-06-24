class LastActivity < ActiveRecord::Base
  def self.last
    all(:limit => 9,:order => 'created_At DESC')
  end
end
