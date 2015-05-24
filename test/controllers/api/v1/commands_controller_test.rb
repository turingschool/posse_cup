require "test_helper"
require "minitest/spec"

class Api::V1::CommandsControllerTest < ActionController::TestCase
  def setup
    ENV["SLACK_AUTH_TOKEN"] = "pizza"
    Posse.create(name: "Von Neumann")
    @admin_uid = Commands::Base.new("").admins.keys.first
  end

  test "rejects point assignment requests without proper token" do
    post :create, text: "#pc 30 points to Von Neumann", token: "not-pizza"
    assert_response 401
  end

  test "rejects request from non-whitelisted user" do
    post :create, text: "#pc 30 points to Von Neumann", token: "pizza", user_id: "4567"
    assert_response 401
    assert_equal "User not authorized.", JSON.parse(@response.body)["error"]
  end

  test "it returns error message for invalid posse name format" do
    post :create, token: "pizza", user_id: @admin_uid, text: "#PC 30 points"
    assert_response 200
    assert_match "No posse name provided", JSON.parse(@response.body)["text"]
  end

  test "it returns error message for invalid posse name" do
    post :create, token: "pizza", user_id: @admin_uid, text: "#PC 30 points to Pizza"
    assert_response 200
    assert_match "posse Pizza could not be found", JSON.parse(@response.body)["text"]
  end

  test "it adds new point award" do
    post :create, token: "pizza", user_id: @admin_uid, text: "#PC 30 points to Von Neumann"
    assert_response 200
    assert_match "30 points awarded to Von Neumann posse! Current score: 30.", JSON.parse(@response.body)["text"]
    assert_nil PointAward.last.reason
  end

  test "it attributes new point award based on the instructor who assigned it" do
    post :create, token: "pizza", user_id: @admin_uid, text: "#PC 30 points to Von Neumann"
    assert_response 200
    assert_match "30 points awarded to Von Neumann posse! Current score: 30.", JSON.parse(@response.body)["text"]
    assert_equal Commands::Base.new("").admins[@admin_uid], PointAward.last.creator
  end

  test "it returns standings" do
    Posse.first.point_awards.create(amount: 15)
    post :create, text: "#pc standings"
    assert_equal "1st: Von Neumann (15 points)", JSON.parse(@response.body)["text"]
  end

  test "it accepts optional reason when assigning points" do
    post :create, token: "pizza", user_id: @admin_uid, text: "#PC 30 points to Von Neumann for cleaning toilets"
    assert_response 200
    assert_match "30 points awarded to Von Neumann posse! Current score: 30.", JSON.parse(@response.body)["text"]
    assert_equal "cleaning toilets", PointAward.last.reason
    assert_equal "Horace", PointAward.last.creator
  end

  test "it can assign points to appropriate posse using a student name" do
    p = Posse.first
    s = Student.create(name: "Student", slack_uid: "1234", posse: p, slack_name: "stoodent")
    post :create, token: "pizza", user_id: @admin_uid, text: "#PC 30 points to <@1234>"
    assert_response 200
    assert_match "30 points awarded to #{p.name} posse! Current score: 30.", JSON.parse(@response.body)["text"]
    assert_equal 30, p.current_score
  end

  test "it can assign points with reason to appropriate posse using a student name" do
    # format is: "#pc 1 point to <@U044EKRGP> for testing the posse cup"
    p = Posse.first
    s = Student.create(name: "Student", slack_uid: "1234", posse: p, slack_name: "stoodent")
    post :create, token: "pizza", user_id: @admin_uid, text: "#PC 30 points to <@1234> for pizza"
    assert_response 200
    assert_match "30 points awarded to #{p.name} posse! Current score: 30.", JSON.parse(@response.body)["text"]
    assert_equal 30, p.current_score
    assert_equal "pizza", PointAward.last.reason
  end

  test "it can returns error for invalid at-mention" do
    # format is: "#pc 1 point to <@U044EKRGP> for testing the posse cup"
    p = Posse.first
    s = Student.create(name: "Student", slack_uid: "1234", posse: p, slack_name: "stoodent")
    post :create, token: "pizza", user_id: @admin_uid, text: "#PC 30 points to <@5678> for pizza"
    assert_response 200
    assert_match "Sorry, posse <@5678> could not be", JSON.parse(@response.body)["text"]
  end
end
