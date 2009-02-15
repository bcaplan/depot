require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "raises when deleting last user" do
    User.first.destroy
    assert_raise RuntimeError do  
      User.first.destroy
    end
  end
  
  test "authentication with good info" do
    assert_not_nil User.authenticate 'Cookie Monster', 'cookie'
  end
  
  test "authentication with bad info" do
    assert_nil User.authenticate 'Person', 'password'
  end
end
