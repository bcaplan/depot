require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  
  test "logging in" do
    post :login, :name => 'Cookie Monster', :password => 'cookie'
    assert_redirected_to :action => "index"
  end
  
  test "logging in takes you to original destination" do
    @request.session[:original_uri] = "/products"
    post :login, :name => 'Cookie Monster', :password => 'cookie'
    assert_redirected_to :controller => "products", :action => "index"
  end
  
  test "logging out" do
    @request.session[:user_id] = users(:one).id
    post :logout
    assert @request.session[:user_id] == nil
  end
  
  test "cannot log in with bad password" do
    post :login, :name => 'Cookie Monster', :password => 'doughnut'
    assert_response :success
    assert @request.session[:user_id] == nil
    assert flash[:notice]
  end
  
  test "cannot log in with bad user" do
    post :login, :name => 'Anonymous', :password => 'canhazaccess?'
    assert_response :success
    assert @request.session[:user_id] == nil
    assert flash[:notice]
  end
  
  test "cannot access admin unless logged in" do
    get :index
    assert_redirected_to :action => "login"
  end
end
