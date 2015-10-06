class Cup < ActiveRecord::Base
  has_many :point_awards
  belongs_to :posse

  def self.declare_victor!
    cup = Cup.create!(posse: PointAward.current_leader)
    PointAward.in_current_round.update_all(cup_id: cup.id)
  end
end
