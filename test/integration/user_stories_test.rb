require 'test_helper'

class UserStoriesTest < ActionController::IntegrationTest
  fixtures :products

  test "buying a product" do
    
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:one)
    
    get '/store/index'
    assert_response :success
    assert_template 'index'
    
    xml_http_request :put, "/store/add_to_cart", :id => ruby_book.id
    assert_response :success
    
    cart = session[:cart]
    assert_equal 1, cart.items.size
    assert_equal ruby_book, cart.items[0].product
    
    post '/store/checkout'
    assert_response :success
    assert_template 'checkout'
    
    post_via_redirect '/store/save_order',
                      :order => { :name     => 'George Foreman',
                                  :address  => '1234 Grillin ln',
                                  :email    => 'george@leanmeangrillinmachine.buy',
                                  :pay_type => 'cc' }
                                  
    assert_response :success
    assert_template 'index'
    assert_equal 0, session[:cart].items.size
    
    orders = Order.find(:all)
    assert_equal 1, orders.size
    order = orders[0]
    
    assert_equal 'George Foreman',                    order.name
    assert_equal '1234 Grillin ln',                   order.address
    assert_equal 'george@leanmeangrillinmachine.buy', order.email
    assert_equal 'cc',                                order.pay_type
    
    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product
  end
end
