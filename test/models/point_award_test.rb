require 'test_helper'

class PointAwardTest < ActiveSupport::TestCase
  test "in current round" do
    c = Cup.create
    p = Posse.create(name: "pizza")
    PointAward.create(amount: 15, posse_id: p.id, cup_id: c.id)
    PointAward.create(amount: 20, posse_id: p.id)
    PointAward.create(amount: 7, posse_id: p.id)
    assert_equal 27, PointAward.in_current_round.sum(:amount)
  end

  test "current leader" do
    p1 = Posse.create(name: "pizza")
    p2 = Posse.create(name: "calzone")
    PointAward.create(amount: 15, posse: p1)
    PointAward.create(amount: 20, posse: p2)
    PointAward.create(amount: 7, posse: p1)
    assert_equal p1, PointAward.current_leader
  end
end
