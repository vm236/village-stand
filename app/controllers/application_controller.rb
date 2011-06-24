class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :admin?
  helper_method :admin_authorize
  helper_method :cart_has_items?
  helper_method :farmer?

  private
  def admin?
    (current_user.try(:role) == 'admin') ? true : false
  end


  def admin_authorize
    unless admin?
      redirect_to root_url, :notice => 'Please login as admin to access this page.'
    end
  end

  def farmer?
     (current_user.try(:role) == 'farmer') ? true : false
  end

  def user_can_have_farm?
    unless farmer?
      redirect_to root_path, :notice => 'You need to be a farmer for this action.'
    end
  end

  def user_exist?
       if current_user.nil?
          redirect_to root_url, :notice => 'Log in please'
      end
  end


#  def current_cart
#    Cart.find(session[:cart_id])
#  rescue ActiveRecord::RecordNotFound
#    cart = Cart.create
#    session[:cart_id] = cart.id
#    cart
#  end
#
  def cart_has_items?
    unless current_user.nil?
      current_user.carts.last.cart_items.empty?? 'shopping_cart.png' : 'shopping_cart_add.png'
    else
      Cart.find(session[:cart_id]).cart_items.empty?? 'shopping_cart.png' : 'shopping_cart_add.png'
    end
  end


  def get_user_address
    address = Geocoder.coordinates(current_user.try(:address))
    address = Geocoder.coordinates(request.location.country + ',' + request.location.city) unless address
    address
  end


  def sort_by_price(farm)
    price = 0.0
    farm.farm_products.each do |f|
      price += (f.quantity.to_f / f.price.to_f).to_f
    end
    price
  end
end
