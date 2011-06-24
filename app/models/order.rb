class Order < ActiveRecord::Base
  belongs_to :cart
  validates_presence_of :ship_address, :city, :state, :zip, :cc_number, :telephone
  after_create :create_last_activity_message
  validate :credit_card_number

  def create_last_activity_message
    cart_id = self.cart_id
    unless Cart.find(cart_id).user.nil?
    LastActivity.create(:message => "#{Cart.find(cart_id).user.username} is ordered some vegetables.")
    else
    LastActivity.create(:message => "Someone is ordered some vegetables.")
    end
  end

  def credit_card_number
    errors.add_to_base("#{cc_number} is invalid credit card number") if cc_number.present? && !cc_number.creditcard?
  end

end
