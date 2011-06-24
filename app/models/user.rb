class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :username
  validates_uniqueness_of :username

  has_many :carts
  has_many :votes
  has_one :farm

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :role,
                  :latitude, :longitude,:first_name, :last_name, :username

  after_create :create_last_activity_message
  def create_cart(cart, order)
    Rails.logger.debug('cart is: ' + cart.inspect + 'order is: ' + order.inspect)
    if cart.nil? or cart.nil?
      unless Cart.last.try(:cart_items).empty?
        Cart.create(:user_id => self.id)
      end
    else
      cart = Cart.find(cart)
      cart.user_id = self.id
      cart.save
      Cart.create(:user_id => self.id)
    end
  end

  def create_last_activity_message
    LastActivity.create(:message => "#{self.username} is joined our community!")
  end

end
