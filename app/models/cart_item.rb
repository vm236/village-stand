class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :farm_product

  def total_price
    farm_product.price * quantity
  end

end
