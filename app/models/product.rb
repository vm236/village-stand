class Product < ActiveRecord::Base
  validates_presence_of :title, :logo
  has_many :farm_products, :dependent => :destroy
  has_many :farms, :through => :farm_products, :foreign_key => :farm_id

  attr_accessor :logo

  mount_uploader :logo, ProductLogoUploader
end
