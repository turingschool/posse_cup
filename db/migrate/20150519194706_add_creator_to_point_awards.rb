class AddCreatorToPointAwards < ActiveRecord::Migration
  def change
    add_column :point_awards, :creator, :string
  end
end
