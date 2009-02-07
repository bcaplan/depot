require 'test_helper'

class CartTest < ActiveSupport::TestCase
  def test_initialize
    cart = Cart.new
    
    assert_equal 0, cart.items.length
  end
  
  def test_add_product
    cart = Cart.new
    cart << products(:one)
    
    assert_equal 1, cart.items.length
  end
  
  def test_total_price
    cart = Cart.new
    cart << products(:one)
    cart << products(:two)
    
    assert_equal 300, cart.total_price
  end
  
  def test_total_items
    cart = Cart.new
    cart << products(:one)
    cart << products(:two)
    
    assert_equal 2, cart.total_items
  end
end