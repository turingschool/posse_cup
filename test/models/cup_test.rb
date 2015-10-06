require "test_helper"

class CupTest < ActiveSupport::TestCase
  test "declare victor!" do
    p1 = Posse.create(name: "pizza")
    p2 = Posse.create(name: "calzone")
    PointAward.create(amount: 15, posse: p1)
    PointAward.create(amount: 20, posse: p2)
    PointAward.create(amount: 7, posse: p1)
    Cup.declare_victor!
    assert_empty PointAward.in_current_round
    assert_equal p1, Cup.last.posse
  end
end
