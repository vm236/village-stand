class AdminsController < ApplicationController
  before_filter :admin_authorize
  def index
    render :layout => 'admin'
  end
end
