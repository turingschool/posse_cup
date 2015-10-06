class AddCupIdToPointAwards < ActiveRecord::Migration
  def change
    add_reference :point_awards, :cup, index: true
  end
end
