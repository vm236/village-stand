class CartItemsController < ApplicationController
  # GET /cart_items
  # GET /cart_items.xml
  def index
    @cart_items = CartItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cart_items }
    end
  end

  # GET /cart_items/1
  # GET /cart_items/1.xml
  def show
    @cart_item = CartItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cart_item }
    end
  end

  # GET /cart_items/new
  # GET /cart_items/new.xml
  def new
    @cart_item = CartItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cart_item }
    end
  end

  # GET /cart_items/1/edit
  def edit
    @cart_item = CartItem.find(params[:id])
  end

  # POST /cart_items
  # POST /cart_items.xml
  def create
    if current_user.nil?
    if session[:cart_id].nil?
        @cart = Cart.create
        @cart.save
        session[:cart_id] = @cart.id
    end
      @cart = Cart.find session[:cart_id]
    else
      @cart = current_user.carts.last
    end
    farm_product = FarmProduct.find(params[:farm_product_id])
      Rails.logger.debug(@cart.inspect)
    @cart_item = @cart.add_farm_product(farm_product)
      Rails.logger.debug(@cart_item.inspect)
    respond_to do |format|
      if @cart_item.save
        format.js { render :layout => false}
        format.html { redirect_to(:back) }
        format.xml  { render :xml => @cart_item, :status => :created, :location => @cart_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cart_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cart_items/1
  # PUT /cart_items/1.xml
  def update
    @cart_item = CartItem.find(params[:id])

    respond_to do |format|
      if @cart_item.update_attributes(params[:cart_item])
        format.html { redirect_to(@cart_item, :notice => 'Cart item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cart_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.xml
  def destroy
    if current_user.nil?
      @cart = Cart.find session[:cart_id]
    else
      @cart = current_user.carts.last
    end
    farm_product = FarmProduct.find(params[:farm_product_id])
    @cart.delete_product(farm_product.id)
        respond_to do |format|
#          format.js { render :layout => false}
          format.html { redirect_to :back }
          format.xml  { head :ok }
        end


  end
end
