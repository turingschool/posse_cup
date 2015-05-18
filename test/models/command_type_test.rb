require "test_helper"

class CommandTypeTest < ActiveSupport::TestCase
  test "it returns 401 status for invalid token on point award request" do
    assert_equal 401, CommandType.parse("#pc 30 points to Von Neumann").response["status"]
  end

  test "it returns 200 status for any user_id on standings request" do
    assert_equal 200, CommandType.parse("#pc standings").response["status"]
  end
end
