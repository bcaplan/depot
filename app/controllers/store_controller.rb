class StoreController < ApplicationController
  def index
    find_cart
    @products = Product.find_products_for_sale
  end
  
  def add_to_cart
    begin
      product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid product \"#{params[:id]}\"")
      redirect_to_index "\"#{params[:id]}\" is an invalid product", 'error'
    else
      @cart = find_cart
      @cart << product
    end
  end
  
  def empty_cart
    session[:cart] = nil
    redirect_to_index "Your cart has been emptied", 'notice'
  end

  private
  
  def redirect_to_index(msg, type='notice')
    flash[type.to_sym] = msg
    redirect_to :action => 'index'
  end
  
  def find_cart
    session[:cart] ||= Cart.new
  end
end
