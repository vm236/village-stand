class Vote < ActiveRecord::Base
  belongs_to :farm, :counter_cache => true
  belongs_to :user
end
