require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @request.session[:user_id] = users(:one).id
  end
  
  test "should not be able to delete last user" do
    delete :destroy, :id => users(:one).id
    assert User.count == 1
    delete :destroy, :id => users(:two).id
    assert User.count == 1
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => {
          :name             => 'John Doe',
          :hashed_password  => User.encrypted_password('fake', 'person'),
          :salt             => 'person'
        }
    end
    
    assert flash[:notice]
    assert_redirected_to :controller => 'users', :action => 'index'
  end

  test "should show user" do
    get :show, :id => users(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => users(:one).id
    assert_response :success
  end

  test "should update user" do
    put :update, :id => users(:one).id, :user => { }
    
    assert flash[:notice]
    assert_redirected_to :controller => 'users', :action => 'index'
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:one).id
    end

    assert_redirected_to users_path
  end
end
