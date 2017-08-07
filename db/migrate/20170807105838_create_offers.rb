class CreateOffers < ActiveRecord::Migration[5.1]
  def change
    create_table :offers do |t|
      t.integer :bundle_id, null: false
      t.integer :segment_id
      t.integer :price, null: false

      t.timestamps
    end
  end
end
