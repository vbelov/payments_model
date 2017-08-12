class CreateSegments < ActiveRecord::Migration[5.1]
  def change
    create_table :segments do |t|
      t.string :type
      t.json :data, default: {}

      t.timestamps
    end
  end
end
