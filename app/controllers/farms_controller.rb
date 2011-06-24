class FarmsController < ApplicationController
  inherit_resources
  action :all, :except => [:create, :update]
  before_filter :admin_authorize, :only => [:index, :show]
#  before_filter :another_message_for_farmer, :only => :show
  before_filter :user_can_have_farm?, :only => [:update, :new, :create]

  def index
    index! do |format|
      format.html { render :layout => 'admin' }
    end
  end

  def create
    @farm = Farm.new(params[:farm])
    @farm.user_id = current_user.id
    respond_to do |format|
      if @farm.save
        format.html { redirect_to(farmer_url, :notice => 'Your farm was successfully created.') }
        format.xml  { render :xml => @farm, :status => :created, :location => @farm }
      else
        format.html { render :action => "new", :layout => 'application' }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end
  def update

    @farm = Farm.find(params[:id])
    respond_to do |format|
      if @farm.update_attributes(params[:farm])
         if farmer?
         format.html { redirect_to farmer_url, :notice => 'Farm was successfully updated.'}
         end
        format.html { redirect_to(@cart, :notice => 'Farm was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    show! do |format|
      format.html { render :layout => 'admin' }
    end
  end

  def another_message_for_farmer
    unless admin? && farmer?
      admin_authorize
    end
    if farmer?
      redirect_to root_path, :notice => 'Your farm successfully updated'
    end
  end
end
