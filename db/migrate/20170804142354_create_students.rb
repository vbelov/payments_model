class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.integer :region_id
      t.integer :level
      t.string :b2what
      t.json :premium_until, default: {}

      t.timestamps
    end
  end
end
