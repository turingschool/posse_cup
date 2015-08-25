class PointAward < ActiveRecord::Base
  belongs_to :posse
  validates_numericality_of :amount, only_integer: true

  default_scope { (where archived_at: nil) }

  def self.archive_all!
    update_all(archived_at: Time.now)
  end
end
