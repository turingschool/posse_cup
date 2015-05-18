class Posse < ActiveRecord::Base
  has_many :point_awards

  def current_score
    point_awards.pluck(:amount).reduce(:+)
  end
end
