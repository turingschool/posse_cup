class CreatePointAwards < ActiveRecord::Migration
  def change
    create_table :point_awards do |t|
      t.integer :amount
      t.references :posse, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
