require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @order = Order.new
    @order.name     = orders(:one).name
    @order.address  = orders(:one).address
    @order.email    = orders(:one).email
    @order.pay_type = orders(:one).pay_type
  end
  
  test "order has line items" do
    cart = Cart.new
    cart << products(:one)
    cart << products(:two)
    
    @order.add_line_items_from_cart(cart)
    assert @order.line_items.size == 2
  end
end
