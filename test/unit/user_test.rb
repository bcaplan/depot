require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "cannot delete last user" do
    users = User.find(:all)
    assert_raise RuntimeError do
      loop do
        users.first.destroy
        users.shift
      end
    end

    assert_equal 1, users.length
  end
  
  test "authentication with good info" do
    assert_not_nil User.authenticate 'Cookie Monster', 'cookie'
  end
  
  test "authentication with bad info" do
    assert_nil User.authenticate 'Person', 'password'
  end
end
