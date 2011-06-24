class SessionsController < Devise::SessionsController
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    resource.create_cart(session[:cart_id], session[:order_id])
    unless session[:cart_id].nil? and session[:order_id].nil?
            session[:cart_id] = nil
            session[:order_id] = nil
            set_flash_message :notice, :signed_in_with_order if is_navigational_format?
    else
      set_flash_message(:notice, :signed_in) if is_navigational_format?
    end

    sign_in(resource_name, resource)
    respond_with resource, :location => redirect_location(resource_name, resource)
  end

end
