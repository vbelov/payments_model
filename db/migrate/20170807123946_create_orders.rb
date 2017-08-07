class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :offer_id, null: false
      t.integer :student_id, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
