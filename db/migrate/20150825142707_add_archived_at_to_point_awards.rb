class AddArchivedAtToPointAwards < ActiveRecord::Migration
  def change
    add_column :point_awards, :archived_at, :datetime
  end
end
