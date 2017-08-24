class AddAbGroupsToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :ab_groups, :json, default: {}
  end
end
