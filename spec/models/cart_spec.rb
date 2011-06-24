require 'spec_helper'

describe Cart do
  it { should belong_to :user }
  it { should have_many :cart_items }

  describe 'manage products' do
    it 'add product with method add_farm_product' do
      cart = Factory(:cart)
      cart.add_farm_product(Factory(:farm_product))
      cart.should have(1).cart_items
      cart.add_farm_product(Factory(:farm_product))
      cart.should have(2).cart_items
    end
  end
end
