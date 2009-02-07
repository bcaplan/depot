require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "add_to_cart handles bad product" do
    post :add_to_cart, :id => 100
    assert_redirected_to :controller => 'store', :action => 'index'
    assert flash[:error]
  end
  
  test "add_to_cart adds a product to the cart" do
    post :add_to_cart, :id => products(:one).id
    assert_redirected_to :controller => 'store', :action => 'index'
    assert cart = assigns(:cart)
  end
  
  test "session contains cart" do
    get :index
    assert session[:cart]
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)

    Product.find_products_for_sale.each do |product|
      assert_tag :tag => 'h3', :content => product.title
      assert_match /#{sprintf("%01.2f", product.price)}/, @response.body
    end
  end
end
