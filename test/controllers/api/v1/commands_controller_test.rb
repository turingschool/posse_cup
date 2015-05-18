require "test_helper"
require "minitest/spec"

class Api::V1::CommandsControllerTest < ActionController::TestCase
  def setup
    ENV["SLACK_AUTH_TOKEN"] = "pizza"
    Posse.create(name: "Von Neumann")
  end

  test "rejects point assignment requests without proper token" do
    post :create, text: "#pc 30 points to Von Neumann", token: "not-pizza"
    assert_response 401
  end

  test "rejects request from non-whitelisted user" do
    skip
    post :create, token: "pizza", user_id: "4567"
    assert_response 401
    assert_equal "User not authorized.", JSON.parse(@response.body)["error"]
  end

  test "it returns error message for invalid posse name format" do
    skip
    post :create, token: "pizza", user_id: "1234", text: "#PC 30 points"
    assert_response 200
    assert_match "No posse name provided", JSON.parse(@response.body)["text"]
  end

  test "it returns error message for invalid posse name" do
    skip
    post :create, token: "pizza", user_id: "1234", text: "#PC 30 points to Pizza"
    assert_response 200
    assert_match "Posse Pizza could not be found", JSON.parse(@response.body)["text"]
  end

  test "it adds new point award" do
    skip
    post :create, token: "pizza", user_id: "1234", text: "#PC 30 points to Von Neumann"
    assert_response 200
    assert_match "30 points awarded to Von Neumann posse! Current score: 30.", JSON.parse(@response.body)["text"]
  end
end
