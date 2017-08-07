class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :student_id
      t.integer :order_id
      t.integer :amount
      t.boolean :processed, default: false

      t.timestamps
    end
  end
end
