class RemoveArchivedAtFromPointAwards < ActiveRecord::Migration
  def up
    remove_column :point_awards, :archived_at
  end

  def down
    add_column :point_awards, :archived_at, :datetime
  end
end
