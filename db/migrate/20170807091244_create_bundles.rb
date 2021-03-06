class CreateBundles < ActiveRecord::Migration[5.1]
  def change
    create_table :bundles do |t|
      t.string :name
      t.json :items_json, default: {}
      t.integer :price, null: false

      t.timestamps
    end
  end
end
