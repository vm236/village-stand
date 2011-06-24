class OrdersController < ApplicationController
  layout 'admin', :except => [:new, :create]
  before_filter :admin_authorize, :except => [:new, :create]

  # GET /orders
  # GET /orders.xml
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
   unless current_user.nil?
     @cart = current_user.carts.last
   else
     @cart = Cart.find session[:cart_id]
   end
    @order = Order.new
    respond_to do |format|
      format.html { render :layout => 'application'}
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
    unless current_user.nil?
     @cart = current_user.carts.last
    else
     @cart = Cart.find session[:cart_id]
    end
    @order = Order.new(params[:order])
    @order.cart_id = params[:cart_id]
    if current_user.nil?
      respond_to do |format|
        if @order.save
          session[:order_id] = @order.id
          format.html { redirect_to(new_user_registration_path, :notice => 'Please sign up or login!') }
        else
          format.html { render :action => "new", :layout => 'application' }
        end
      end
    else
      respond_to do |format|
        if @order.save
          current_user.create_cart
          format.html { redirect_to(root_path, :notice => 'Your order was successfully saved. We will contact with you as soon as possible.') }
          format.xml  { render :xml => @order, :status => :created, :location => @order }
        else
          format.html { render :action => "new", :layout => 'application' }
          format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
end
