class UsersController < ApplicationController
  before_filter :admin_authorize
  layout 'admin'
  inherit_resources
  def index
    @users = User.where("id NOT IN (?)", current_user.id)
  end

  def update
#    update! { redirect_to users_path, :notice => 'User information has been updated' }
    update! do |format|
      format.html { redirect_to users_path, :notice => 'User information has been updated' }
    end
  end
end
