require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  test "from cart item" do
    product = products(:one)
    cart_item = CartItem.new(product)
    line_item = LineItem.from_cart_item(cart_item)
    
    assert_equal product, line_item.product
    assert_equal 1, line_item.quantity
    assert_equal product.price, line_item.total_price
  end
  
  test "from cart item with many of the same products" do
    product = products(:one)
    cart_item = CartItem.new(product)
    cart_item.increment_quantity
    
    line_item = LineItem.from_cart_item(cart_item)
    
    assert_equal product, line_item.product
    assert_equal 2, line_item.quantity
    assert_equal cart_item.price, line_item.total_price
  end
  
  test "line item has order" do
    line_item = line_items(:one)
    line_item.order = orders(:one)
    line_item.save!
    
    assert_equal orders(:one), line_item.order
  end
end
