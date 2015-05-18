class PointAward < ActiveRecord::Base
  belongs_to :posse
  validates_numericality_of :amount, only_integer: true
end
