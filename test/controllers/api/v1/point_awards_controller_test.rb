require "test_helper"
require "minitest/spec"


class Api::V1::PointAwardsControllerTest < ActionController::TestCase
  def setup
    ENV["SLACK_AUTH_TOKEN"] = "pizza"
    Posse.create(name: "Von Neumann")
  end

  test "rejects reqs without proper token" do
    post :create, token: "not-pizza"
    assert_response 401
  end

  test "rejects request from non-whitelisted user" do
    post :create, token: "pizza", user_id: "4567"
    assert_response 401
    assert_equal "User not authorized.", JSON.parse(@response.body)["error"]
  end

  #text=googlebot: What is the air-speed velocity of an unladen swallow?
  #text=#PC 30 points to Von Neumann
  #text=#PC -30 points to Von Neumann
  test "it returns error message for invalid posse name format" do
    post :create, token: "pizza", user_id: "1234", text: "#PC 30 points"
    assert_response 200
    assert_match "No posse name provided", JSON.parse(@response.body)["text"]
  end

  test "it returns error message for invalid posse name" do
    post :create, token: "pizza", user_id: "1234", text: "#PC 30 points to Pizza"
    assert_response 200
    assert_match "Posse Pizza could not be found", JSON.parse(@response.body)["text"]
  end

  test "it adds new point award" do
    post :create, token: "pizza", user_id: "1234", text: "#PC 30 points to Von Neumann"
    assert_response 200
    assert_match "30 points awarded to Von Neumann posse! Current score: 30.", JSON.parse(@response.body)["text"]
  end
end
# describe Api::V1::PointAwardsController do
#   before do
#   end


#   it "adds new point award" do
    
#   end

#   it "returns new info about current point total" do
    
#   end
# end

# token=NmusKPMKNPnL8ZrP71y7pSsb
# team_id=T0001
# team_domain=example
# channel_id=C2147483705
# channel_name=test
# timestamp=1355517523.000005
# user_id=U2147483697
# user_name=Steve
# text=googlebot: What is the air-speed velocity of an unladen swallow?
# trigger_word=googlebot:
