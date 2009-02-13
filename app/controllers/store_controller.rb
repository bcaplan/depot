class StoreController < ApplicationController
  
  before_filter :find_cart, :except => :empty_cart
  
  def index
    @products = Product.find_products_for_sale
  end
  
  def add_to_cart
    begin
      product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid product \"#{params[:id]}\"")
      redirect_to_index "\"#{params[:id]}\" is an invalid product", :error
    else
      @current_item = @cart << product
      respond_to do |format|
        format.js if request.xhr?
        format.html {redirect_to_index}
      end
    end
  end
  
  def empty_cart
    session[:cart] = nil
    respond_to do |format|
      format.js if request.xhr?
      format.html {redirect_to_index}
    end
  end
  
  def checkout
    if @cart.items.empty?
      redirect_to_index 'Your cart is empty', :error
    else
      @order = Order.new
    end
  end
  
  def save_order
    @order = Order.new(params[:order]) 
    @order.add_line_items_from_cart(@cart) 
    if @order.save                     
      session[:cart] = nil
      redirect_to_index("Thank you for your order!")
    else
      render :action => 'checkout'
    end
  end

private
  
  def redirect_to_index(msg = nil, type = 'notice')
    flash[type.to_sym] = msg if msg
    redirect_to :action => 'index'
  end
  
  def find_cart
    @cart = session[:cart] ||= Cart.new
  end
  
protected

  def authorize
    # Override for application controller authorization
  end
  
end
