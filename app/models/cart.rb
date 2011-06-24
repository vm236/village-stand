class Cart < ActiveRecord::Base
  belongs_to :user
  has_one :order
  has_many :cart_items, :dependent => :destroy

  def delete_product(farm_product_id)
    current_item = cart_items.where(:farm_product_id => farm_product_id).first
      unless current_item.nil?
        if current_item.quantity > 1
           current_item.quantity -= 1
              cart_items << current_item
        else
           current_item.destroy
        end
      end
  end

  def add_farm_product(farm_product)
    current_item = cart_items.where(:farm_product_id => farm_product.id).first
    Rails.logger.debug(current_item.inspect)
    if current_item
      current_item.quantity += 1
    else
      current_item = cart_items.build(:farm_product_id => farm_product.id)
    end
    current_item
  end

  def total_price
    cart_items.to_a.sum { |item| item.total_price }
  end


end
