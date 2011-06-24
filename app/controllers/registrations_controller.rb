class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
      build_resource

      if resource.save
        resource.create_cart(session[:cart_id], session[:order_id])

        if resource.active_for_authentication?
          unless session[:cart_id].nil? and session[:order_id].nil?
            session[:cart_id] = nil
            session[:order_id] = nil
            set_flash_message :notice, :signed_up_with_order if is_navigational_format?
          else
            set_flash_message :notice, :signed_up if is_navigational_format?
          end
          sign_in(resource_name, resource)
          respond_with resource, :location => redirect_location(resource_name, resource)
        else
          set_flash_message :notice, :inactive_signed_up, :reason => resource.inactive_message.to_s if is_navigational_format?
          expire_session_data_after_sign_in!
          respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords(resource)
        respond_with_navigational(resource) { render_with_scope :new }
      end
    end

end
