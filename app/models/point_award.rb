class PointAward < ActiveRecord::Base
  belongs_to :posse
  belongs_to :cup
  validates_numericality_of :amount, only_integer: true

  default_scope { (where cup_id: nil) }

  def self.archive_all!
    update_all(archived_at: Time.now)
  end

  def self.in_current_round
    where(cup_id: nil)
  end

  def self.current_leader
    leader_id = in_current_round.
                group(:posse_id).
                sum(:amount).
                max_by(&:last).
                first
    Posse.find(leader_id)
  end
end
