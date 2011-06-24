class FarmProduct < ActiveRecord::Base
  belongs_to :farm
  belongs_to :product
  has_many :cart_items

  before_destroy :ensure_not_referenced_by_any_cart_item

  def ensure_not_referenced_by_any_cart_item
    if cart_items.count.zero?
      true
    else
      errors.add(:base, 'Items present in the cart')
      false
    end
  end
end
