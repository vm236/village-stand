class Farm < ActiveRecord::Base
  validates_presence_of :name, :harvest, :about, :offers, :logo, :address

  has_many :farm_products, :dependent => :destroy
  has_many :products, :through => :farm_products, :foreign_key => :product_id
  has_many :votes
  has_one :user

  accepts_nested_attributes_for :farm_products, :allow_destroy => true, :reject_if => :all_blank

  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
#  paginates_per 3
  attr_accessor :logo

  mount_uploader :logo, FarmsLogoUploader


end
