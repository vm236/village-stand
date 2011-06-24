class CartsController < ApplicationController
  # GET /carts
  # GET /carts.xml
  def index
    @carts = Cart.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @carts }
    end
  end

  # GET /carts/1
  # GET /carts/1.xml
  def show
    begin
      unless current_user.nil?
        @cart = Cart.find(params[:id])
        raise CartsHelper::NotMyCart unless @cart.user_id.eql?(current_user.id)
      else
        @cart = Cart.find session[:cart_id]
      end
      rescue ActiveRecord::RecordNotFound
        redirect_to marketplace_url, :notice => 'Invalid cart'
    else
      Rails.logger.debug('Cart show' + @cart.cart_items.inspect)
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @cart }
      end
      end
    rescue CartsHelper::NotMyCart => e
      redirect_to marketplace_url, :notice => e.message
    end
  end

  # GET /carts/new
  # GET /carts/new.xml
  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cart }
    end
  end

  # GET /carts/1/edit
  def edit
    @cart = Cart.find(params[:id])
  end

  # POST /carts
  # POST /carts.xml
  def create
    @cart = Cart.new(params[:cart])

    respond_to do |format|
      if @cart.save
        format.html { redirect_to(@cart, :notice => 'Cart was successfully created.') }
        format.xml  { render :xml => @cart, :status => :created, :location => @cart }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.xml
  def update
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to(@cart, :notice => 'Cart was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.xml
  def destroy
    @cart = current_user.cart.last
    @cart.cart_items.destroy_all
    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to(root_url, :notice => 'Your cart is empty') }
      format.xml  { head :ok }
    end
  end




