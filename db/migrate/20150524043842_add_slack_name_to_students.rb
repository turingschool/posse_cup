class AddSlackNameToStudents < ActiveRecord::Migration
  def change
    add_column :students, :slack_name, :string
  end
end
