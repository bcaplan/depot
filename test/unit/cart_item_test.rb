require 'test_helper'

class CartItemTest < ActiveSupport::TestCase
  def test_cart_item_quantity
    cart = Cart.new
    cart << products(:one)
    cart << products(:one)

    assert_equal 2, cart.items.first.quantity
  end

  def test_cart_item_price
    cart = Cart.new
    cart << products(:one)
    cart << products(:one)

    assert_equal products(:one).price * 2, cart.items.first.price
  end
  
end