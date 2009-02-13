require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  def setup
    @request.session[:user_id] = users(:one).id
  end
 
end
