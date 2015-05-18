class Posse < ActiveRecord::Base
  has_many :point_awards

  def current_score
    point_awards.pluck(:amount).reduce(0, :+)
  end

  def as_json(options = {})
    o = options.merge(methods: [:current_score], except: [:created_at, :updated_at])
    super(o)
  end
end
