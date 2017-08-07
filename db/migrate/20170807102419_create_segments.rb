class CreateSegments < ActiveRecord::Migration[5.1]
  def change
    create_table :segments do |t|
      t.integer :region_ids, default: [], array: true
      t.integer :payments
      t.string :b2what
      t.integer :levels, default: [], array: true
      t.integer :trials_count

      t.timestamps
    end
  end
end
