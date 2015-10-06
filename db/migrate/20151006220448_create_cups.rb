class CreateCups < ActiveRecord::Migration
  def change
    create_table :cups do |t|
      t.references :posse
      t.timestamps
    end
  end
end
