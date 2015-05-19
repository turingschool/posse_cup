require File.expand_path("../../test_helper", __FILE__)

class CommandsTest < ActiveSupport::TestCase
  def setup
    ENV["SLACK_AUTH_TOKEN"] = "pizza"
    @admin_uid = "U02MYKGQB"
  end

  test "it returns 401 status for invalid token on point award request" do
    resp = Commands.parse("#pc 30 points to Von Neumann",
                          token: "invalid",
                          user_id: @admin_uid).response["status"]

    assert_equal 401, resp
  end

  test "it returns 401 on award without admin uid" do
    resp = Commands.parse("#pc 30 points to Von Neumann",
                          token: ENV["SLACK_AUTH_TOKEN"],
                          user_id: "invalid").response["status"]
    assert_equal 401, resp
  end

  test "it returns invalid message for non-numeric amount" do
    resp = Commands.parse("#pc asdf points to Von Neumann",
                          token: ENV["SLACK_AUTH_TOKEN"],
                          user_id: @admin_uid).response
    assert_equal 200, resp["status"]
    assert_match "amount isn't valid", resp["json"]["text"]
  end

  test "it returns error message for invalid posse name" do
    resp = Commands.parse("#pc 30 points to Not a Posse",
                          token: ENV["SLACK_AUTH_TOKEN"],
                          user_id: @admin_uid).response
    assert_match "posse Not a Posse could not be found", resp["json"]["text"]
    assert_equal 200, resp["status"]
  end

  test "it adds new point award for valid awards" do
    p = Posse.create(name: "Von Neumann")
    resp = Commands.parse("#pc 30 points to Von Neumann",
                          token: ENV["SLACK_AUTH_TOKEN"],
                          user_id: @admin_uid).response
    assert_equal "30 points awarded to Von Neumann posse! Current score: 30.", resp["json"]["text"]
    assert_equal 200, resp["status"]
    assert_equal 30, p.current_score
  end

  test "it adds new singular point award for valid awards" do
    p = Posse.create(name: "Von Neumann")
    resp = Commands.parse("#pc 1 point to Von Neumann",
                          token: ENV["SLACK_AUTH_TOKEN"],
                          user_id: @admin_uid).response
    assert_equal "1 point awarded to Von Neumann posse! Current score: 1.", resp["json"]["text"]
    assert_equal 200, resp["status"]
    assert_equal 1, p.current_score
  end

  test "it returns 200 status for any user_id on standings request" do
    assert_equal 200, Commands.parse("#pc standings").response["status"]
  end

  test "it calculates standings message" do
    p = Posse.create(name: "Von Neumann")
    p.point_awards.create(amount: 10)
    assert_equal "1st: Von Neumann (10 points)", Commands.parse("#pc standings").response["json"]["text"]
  end

  test "it handles ties in standings" do
    p1 = Posse.create(name: "Von Neumann")
    p2 = Posse.create(name: "Pizza")
    p1.point_awards.create(amount: 10)
    p2.point_awards.create(amount: 10)
    assert_equal "1st (tie): Von Neumann, Pizza (10 points)", Commands.parse("#pc standings").response["json"]["text"]
  end
end
