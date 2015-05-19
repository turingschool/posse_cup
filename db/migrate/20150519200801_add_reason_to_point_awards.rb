class AddReasonToPointAwards < ActiveRecord::Migration
  def change
    add_column :point_awards, :reason, :string
  end
end
