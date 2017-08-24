class CreateAbTests < ActiveRecord::Migration[5.1]
  def change
    create_table :ab_tests do |t|
      t.string :type
      t.integer :segment_id
      t.integer :groups_count
      t.json :participants, default: {}

      t.timestamps
    end
  end
end
